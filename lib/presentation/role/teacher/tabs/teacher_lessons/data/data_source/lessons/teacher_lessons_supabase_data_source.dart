import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:edura/core/error/app_error.dart';
import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/data_source/lessons/teacher_lessons_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/lessons/new_lesson_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/error/rethrow_as_app_error.dart';

@LazySingleton(as: TeacherLessonsRemoteDataSource)
class TeacherLessonsSupabaseDataSource
    implements TeacherLessonsRemoteDataSource {
  final supabase = Supabase.instance.client;

  static const _videoBucket = 'lesson-videos';
  static const _pdfBucket = 'lesson-pdfs';
  static const _videoThumbnailBucket = 'videoThumbnail';

  @override
  Future<Map<String, dynamic>> createLesson({
    required NewLessonModel lesson,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw const ServerError();

    String? videoStoragePath;
    String? pdfStoragePath;
    String? videoThumbnailStoragePath;

    try {
      final urls = await _uploadLessonFiles(
        lesson: lesson,
        onVideoUploaded: (path) => videoStoragePath = path,
        onPdfUploaded: (path) => pdfStoragePath = path,
        onVideoThumbnailUploaded: (path) => videoThumbnailStoragePath = path,
      );

      final teacherDetail = await supabase.from('teacher').select().single();
      final teacherName =
          teacherDetail['name'] ??
          user.userMetadata?['full_name'] ??
          'Unknown Teacher';

      return await supabase
          .from('lessons')
          .insert({
            'teacher_id': user.id,
            'title': lesson.title,
            'subject': lesson.subject,
            'duration_minutes': lesson.durationMinutes,
            'overview_description': lesson.description,
            'teacher_name': teacherName,
            'video_url': urls.videoUrl,
            'pdf_url': urls.pdfUrl,
            'video_thumbnail_url': urls.videoThumbnailUrl,
            'is_published': lesson.isPublished,
            'is_premium': lesson.isPremium,
            'is_completed': false,
            'view_count': 0,
            'grade_id': lesson.gradeId,
            'grade': lesson.grade,
            'rating': 0,
            'progress': 0,

            'materials': [],
          })
          .select()
          .single();
    } catch (e) {
      await _rollback(
        videoStoragePath: videoStoragePath,
        pdfStoragePath: pdfStoragePath,
        videoThumbnailStoragePath: videoThumbnailStoragePath,
      );
      rethrowAsAppError(e);
    }
  }

  @override
  Future<List<LessonModel>> getLessons() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw const ServerError();

    try {
      final response = await supabase
          .from('lessons')
          .select()
          .eq('teacher_id', user.id)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => LessonModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrowAsAppError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> updateLesson({
    required String lessonId,
    required NewLessonModel lesson,
    String? currentVideoUrl,
    String? currentPdfUrl,
  }) async {
    final user = supabase.auth.currentUser;

    if (user == null) throw const ServerError();

    String? videoStoragePath;
    String? pdfStoragePath;
    String? oldVideoPath;
    String? oldPdfPath;

    try {
      var videoUrl = currentVideoUrl;
      var pdfUrl = currentPdfUrl;

      if (lesson.videoFile != null) {
        oldVideoPath = _storagePathFromUrl(currentVideoUrl, _videoBucket);
        videoStoragePath = await _upload(
          file: lesson.videoFile!,
          bucket: _videoBucket,
          folder: 'videos',
        );
        videoUrl = _publicUrl(_videoBucket, videoStoragePath);
      }

      if (lesson.pdfFile != null) {
        oldPdfPath = _storagePathFromUrl(currentPdfUrl, _pdfBucket);
        pdfStoragePath = await _upload(
          file: lesson.pdfFile!,
          bucket: _pdfBucket,
          folder: 'pdfs',
        );
        pdfUrl = _publicUrl(_pdfBucket, pdfStoragePath);
      }

      final response = await supabase
          .from('lessons')
          .update({
            'title': lesson.title,
            'subject': lesson.subject,
            'duration_minutes': lesson.durationMinutes,
            'overview_description': lesson.description,
            'video_url': videoUrl,
            'pdf_url': pdfUrl,
            'is_published': lesson.isPublished,
            'is_premium': lesson.isPremium,
          })
          .eq('id', lessonId)
          .eq('teacher_id', user.id)
          .select()
          .single();

      await Future.wait([
        if (oldVideoPath != null) _removeFile(_videoBucket, oldVideoPath),
        if (oldPdfPath != null) _removeFile(_pdfBucket, oldPdfPath),
      ]);

      return response;
    } catch (e) {
      await _rollback(
        videoStoragePath: videoStoragePath,
        pdfStoragePath: pdfStoragePath,
      );
      rethrowAsAppError(e);
    }
  }

  @override
  Future<void> deleteLesson({required String lessonId}) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw const ServerError();

    try {
      final lesson = await supabase
          .from('lessons')
          .select('video_url, pdf_url')
          .eq('id', lessonId)
          .eq('teacher_id', user.id)
          .single();

      await supabase
          .from('lessons')
          .delete()
          .eq('id', lessonId)
          .eq('teacher_id', user.id);

      final videoPath = _storagePathFromUrl(
        lesson['video_url'] as String?,
        _videoBucket,
      );
      final pdfPath = _storagePathFromUrl(
        lesson['pdf_url'] as String?,
        _pdfBucket,
      );

      await Future.wait([
        if (videoPath != null) _removeFile(_videoBucket, videoPath),
        if (pdfPath != null) _removeFile(_pdfBucket, pdfPath),
      ]);
    } catch (e) {
      rethrowAsAppError(e);
    }
  }

  Future<({String? videoUrl, String? pdfUrl, String? videoThumbnailUrl})>
  _uploadLessonFiles({
    required NewLessonModel lesson,
    required void Function(String path) onVideoUploaded,
    required void Function(String path) onPdfUploaded,
    required void Function(String path) onVideoThumbnailUploaded,
  }) async {
    String? videoUrl;
    String? pdfUrl;
    String? videoThumbnailUrl;

    if (lesson.videoFile != null) {
      final path = await _upload(
        file: lesson.videoFile!,
        bucket: _videoBucket,
        folder: 'videos',
      );
      onVideoUploaded(path);
      videoUrl = _publicUrl(_videoBucket, path);
    }

    if (lesson.pdfFile != null) {
      final path = await _upload(
        file: lesson.pdfFile!,
        bucket: _pdfBucket,
        folder: 'pdfs',
      );
      onPdfUploaded(path);
      pdfUrl = _publicUrl(_pdfBucket, path);
    }
    if (lesson.videoThumbnailUrl != null) {
      final path = await _upload(
        file: lesson.videoThumbnailUrl!,
        bucket: _videoThumbnailBucket,
        folder: 'thumbnails',
      );
      onVideoThumbnailUploaded(path);
      videoThumbnailUrl = _publicUrl(_videoThumbnailBucket, path);
    }

    return (
      videoUrl: videoUrl,
      pdfUrl: pdfUrl,
      videoThumbnailUrl: videoThumbnailUrl,
    );
  }

  Future<String> _upload({
    required File file,
    required String bucket,
    required String folder,
  }) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) throw const ServerError();

    final extension = _fileExtension(file.path);
    final storagePath =
        '$folder/$userId/${DateTime.now().millisecondsSinceEpoch}$extension';

    try {
      await supabase.storage
          .from(bucket)
          .upload(
            storagePath,
            file,
            fileOptions: const FileOptions(upsert: false),
          );
      return storagePath;
    } catch (e) {
      log('Error uploading file to Supabase storage: $e');
      rethrowAsAppError(e);
    }
  }

  String _publicUrl(String bucket, String storagePath) {
    return supabase.storage.from(bucket).getPublicUrl(storagePath);
  }

  // https://daxgkzzwfnpyqsjcpnad.supabase.co/storage/v1/object/sign/lesson-videos/videos/49a59561-a58c-4cbf-8572-3c28e15345e3/1789825852175.mp4?token=eyJraWQiOiI2MTc4MzM3OC0wNmQzLTQyOTgtODg2OS01YTM4NGNjMWZhYzUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJsZXNzb24tdmlkZW9zL3ZpZGVvcy80OWE1OTU2MS1hNThjLTRjYmYtODU3Mi0zYzI4ZTE1MzQ1ZTMvMTc4OTgyNTg1MjE3NS5tcDQiLCJzY29wZSI6ImRvd25sb2FkIiwiaWF0IjoxNzkwNTQyMzA1LCJleHAiOjE3OTExNDcxMDV9.Wb3KBDGPtTUakcAFNexXLZO0_49zflRyvOGaHS-kYXc
  String? _storagePathFromUrl(String? url, String bucket) {
    if (url == null || url.isEmpty) return null;

    final marker = '/object/public/$bucket/';
    log("_storagePathFromUrl: url: $url, marker: $marker");
    final index = url.indexOf(marker);
    if (index == -1) return null;

    return Uri.decodeComponent(url.substring(index + marker.length));
  }

  String _fileExtension(String path) {
    final fileName = path.split(Platform.pathSeparator).last;
    final dotIndex = fileName.lastIndexOf('.');
    if (dotIndex == -1 || dotIndex == fileName.length - 1) return '';
    return fileName.substring(dotIndex).toLowerCase();
  }

  Future<void> _rollback({
    String? videoStoragePath,
    String? pdfStoragePath,
    String? videoThumbnailStoragePath,
  }) async {
    await Future.wait([
      if (videoStoragePath != null) _removeFile(_videoBucket, videoStoragePath),
      if (pdfStoragePath != null) _removeFile(_pdfBucket, pdfStoragePath),
      if (videoThumbnailStoragePath != null)
        _removeFile(_videoThumbnailBucket, videoThumbnailStoragePath),
    ]);
  }

  Future<void> _removeFile(String bucket, String path) async {
    try {
      await supabase.storage.from(bucket).remove([path]);
    } catch (_) {}
  }

  @override
  Future<List<LessonModel>> getLessonsByGrade({required String grade}) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw const ServerError();
    //https://daxgkzzwfnpyqsjcpnad.supabase.co/storage/v1/object/sign/lesson-videos/videos/49a59561-a58c-4cbf-8572-3c28e15345e3/1790542801214.mp4?token=eyJraWQiOiI2MTc4MzM3OC0wNmQzLTQyOTgtODg2OS01YTM4NGNjMWZhYzUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJsZXNzb24tdmlkZW9zL3ZpZGVvcy80OWE1OTU2MS1hNThjLTRjYmYtODU3Mi0zYzI4ZTE1MzQ1ZTMvMTc5MDU0MjgwMTIxNC5tcDQiLCJzY29wZSI6ImRvd25sb2FkIiwiaWF0IjoxNzkwNTQzMDE3LCJleHAiOjE3OTExNDc4MTd9.1UYG9TCkeK_aw9vPNVrgPAG9poPYAzI_RgATDN0tkPY
    try {
      final response = await supabase
          .from('lessons')
          .select()
          .eq('grade', grade)
          .eq('is_published', true)
          .order('created_at', ascending: false);

      log('getLessonsByGrade response: $response');

      return (response as List)
          .map((json) => LessonModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrowAsAppError(e);
    }
  }
}
