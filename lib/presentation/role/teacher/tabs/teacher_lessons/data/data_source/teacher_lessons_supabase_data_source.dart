import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:edura/core/error/app_error.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/data_source/teacher_lessons_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/new_lesson_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TeacherLessonsSupabaseDataSource
    implements TeacherLessonsRemoteDataSource {
  final supabase = Supabase.instance.client;

  static const _tag = 'TeacherLessonsSupabaseDataSource';

  @override
  Future<Map<String, dynamic>> createLesson({
    required NewLessonModel lesson,
  }) async {
    String? videoUrl;
    String? pdfUrl;

    String? videoStoragePath;
    String? pdfStoragePath;

    final user = supabase.auth.currentUser;

    log('[$_tag] createLesson: starting for title="${lesson.title}"');

    if (user == null) {
      log('[$_tag] createLesson FAILED: no authenticated user');
      throw const ServerError();
    }

    log('[$_tag] USER ID: ${user.id}');
    log('[$_tag] USER EMAIL: ${user.email}');
    log(
      '[$_tag] USER NAME: '
      '${user.userMetadata?['full_name']}',
    );

    try {

      if (lesson.videoFile != null) {
        log(
          '[$_tag] Step: uploading video '
          '(${lesson.videoFile!.path})',
        );

        videoStoragePath = await _upload(
          file: lesson.videoFile!,
          bucket: 'lesson-videos',
          folder: 'videos',
        );

        videoUrl = supabase.storage
            .from('lesson-videos')
            .getPublicUrl(videoStoragePath);

        log('[$_tag] Step: video uploaded -> $videoUrl');
      } else {
        log('[$_tag] Step: no video file, skipping video upload');
      }

      // ============================================================
      // Upload PDF
      // ============================================================

      if (lesson.pdfFile != null) {
        log(
          '[$_tag] Step: uploading pdf '
          '(${lesson.pdfFile!.path})',
        );

        pdfStoragePath = await _upload(
          file: lesson.pdfFile!,
          bucket: 'lesson-pdfs',
          folder: 'pdfs',
        );

        pdfUrl = supabase.storage
            .from('lesson-pdfs')
            .getPublicUrl(pdfStoragePath);

        log('[$_tag] Step: pdf uploaded -> $pdfUrl');
      } else {
        log('[$_tag] Step: no pdf file, skipping pdf upload');
      }

      // ============================================================
      // Resolve Teacher Name
      // ============================================================

      final teacherName =
          user.userMetadata?['full_name'] ?? user.email ?? 'Teacher';

      log('[$_tag] Step: resolved teacherName="$teacherName"');

      // ============================================================
      // Insert Lesson
      // ============================================================

      log('[$_tag] Step: inserting lesson row into `lessons` table');

      final response = await supabase
          .from('lessons')
          .insert({
        'teacher_id': user.id,

        'title': lesson.title,
        'subject': lesson.subject,
        'duration_minutes': lesson.durationMinutes,
        'overview_description': lesson.description,
        'teacher_name': teacherName,
        'video_url': videoUrl,
        'pdf_url': pdfUrl,
        'is_published': lesson.isPublished,
        'is_premium': lesson.isPremium,
        'is_completed': false,
        'view_count': 0,
        'rating': 0,
        'progress': 0,
        'materials': [],
      })
          .select()
          .single();

      log('[$_tag] createLesson: success, id=${response['id']}');

      return response;
    }
    // ==============================================================
    // Network Errors
    // ==============================================================
    on SocketException catch (e, st) {
      log(
        '[$_tag] createLesson FAILED at network layer',
        error: e,
        stackTrace: st,
      );

      await _rollback(
        videoStoragePath: videoStoragePath,
        pdfStoragePath: pdfStoragePath,
      );

      throw const NoInternetError();
    }
    // ==============================================================
    // Timeout
    // ==============================================================
    on TimeoutException catch (e, st) {
      log(
        '[$_tag] createLesson FAILED: request timed out',
        error: e,
        stackTrace: st,
      );

      await _rollback(
        videoStoragePath: videoStoragePath,
        pdfStoragePath: pdfStoragePath,
      );

      throw const TimeoutError();
    }
    // ==============================================================
    // Database Error
    // ==============================================================
    on PostgrestException catch (e, st) {
      log(
        '[$_tag] createLesson FAILED at DB insert stage: '
        'code=${e.code}, '
        'message=${e.message}, '
        'details=${e.details}',
        error: e,
        stackTrace: st,
      );

      await _rollback(
        videoStoragePath: videoStoragePath,
        pdfStoragePath: pdfStoragePath,
      );

      throw const ServerError();
    }
    // ==============================================================
    // Storage Error
    // ==============================================================
    on StorageException catch (e, st) {
      log(
        '[$_tag] createLesson FAILED at storage stage: '
        'statusCode=${e.statusCode}, '
        'message=${e.message}',
        error: e,
        stackTrace: st,
      );

      await _rollback(
        videoStoragePath: videoStoragePath,
        pdfStoragePath: pdfStoragePath,
      );

      throw const ServerError();
    }
    // ==============================================================
    // Already Mapped AppError
    // ==============================================================
    on AppError catch (e) {
      log('[$_tag] createLesson FAILED: AppError occurred: $e');

      await _rollback(
        videoStoragePath: videoStoragePath,
        pdfStoragePath: pdfStoragePath,
      );

      rethrow;
    }
    // ==============================================================
    // Unknown Error
    // ==============================================================
    catch (e, st) {
      log(
        '[$_tag] createLesson FAILED: unexpected/unmapped error',
        error: e,
        stackTrace: st,
      );

      await _rollback(
        videoStoragePath: videoStoragePath,
        pdfStoragePath: pdfStoragePath,
      );

      throw const UnknownServerError();
    }
  }

  // ==================================================================
  // Upload File
  // ==================================================================

  Future<String> _upload({
    required File file,
    required String bucket,
    required String folder,
  }) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      log('[$_tag] _upload FAILED: no authenticated user');

      throw const ServerError();
    }

    log('[$_tag] USER ID: ${user.id}');
    log('[$_tag] USER EMAIL: ${user.email}');

    // ================================================================
    // Get original file extension only
    // ================================================================

    final originalFileName = file.path.split(Platform.pathSeparator).last;

    final dotIndex = originalFileName.lastIndexOf('.');

    String extension = '';

    if (dotIndex != -1 && dotIndex < originalFileName.length - 1) {
      extension = originalFileName.substring(dotIndex).toLowerCase();
    }

    // ================================================================
    // Create a safe ASCII-only filename
    //
    // Example:
    // 1788267510376.pdf
    //
    // Instead of:
    // 1788267510376_تنقيب البيانات (IS462).pdf
    // ================================================================

    final fileName = '${DateTime.now().millisecondsSinceEpoch}$extension';

    // ================================================================
    // Storage Structure:
    //
    // videos/{userId}/filename.mp4
    // pdfs/{userId}/filename.pdf
    // ================================================================

    final storagePath = '$folder/${user.id}/$fileName';

    final fileSize = await file.length();

    log(
      '[$_tag] _upload: '
      'bucket=$bucket, '
      'path=$storagePath, '
      'sizeBytes=$fileSize',
    );

    try {
      // ==============================================================
      // Upload
      // ==============================================================

      await supabase.storage
          .from(bucket)
          .upload(
            storagePath,
            file,
            fileOptions: const FileOptions(upsert: false),
          );

      log('[$_tag] _upload: success for $storagePath');

      return storagePath;
    }
    // ================================================================
    // Network Error
    // ================================================================
    on SocketException catch (e, st) {
      log(
        '[$_tag] _upload FAILED (no internet): '
        'bucket=$bucket, '
        'path=$storagePath',
        error: e,
        stackTrace: st,
      );

      throw const NoInternetError();
    }
    // ================================================================
    // Timeout
    // ================================================================
    on TimeoutException catch (e, st) {
      log(
        '[$_tag] _upload FAILED (timeout): '
        'bucket=$bucket, '
        'path=$storagePath',
        error: e,
        stackTrace: st,
      );

      throw const TimeoutError();
    }
    // ================================================================
    // Storage Error
    // ================================================================
    on StorageException catch (e, st) {
      log(
        '[$_tag] _upload FAILED (storage): '
        'bucket=$bucket, '
        'path=$storagePath, '
        'statusCode=${e.statusCode}, '
        'message=${e.message}',
        error: e,
        stackTrace: st,
      );

      throw const ServerError();
    }
    // ================================================================
    // Already Mapped Error
    // ================================================================
    on AppError {
      rethrow;
    }
    // ================================================================
    // Unknown Error
    // ================================================================
    catch (e, st) {
      log(
        '[$_tag] _upload FAILED (unexpected): '
        'bucket=$bucket, '
        'path=$storagePath',
        error: e,
        stackTrace: st,
      );

      throw const UnknownServerError();
    }
  }

  // ==================================================================
  // Rollback Uploaded Files
  // ==================================================================

  Future<void> _rollback({
    String? videoStoragePath,
    String? pdfStoragePath,
  }) async {
    // ================================================================
    // Remove Video
    // ================================================================

    if (videoStoragePath != null) {
      try {
        log(
          '[$_tag] Rolling back uploaded video: '
          '$videoStoragePath',
        );

        await supabase.storage.from('lesson-videos').remove([videoStoragePath]);

        log('[$_tag] Video rollback completed');
      } catch (e, st) {
        log(
          '[$_tag] Video rollback FAILED: '
          '$videoStoragePath',
          error: e,
          stackTrace: st,
        );
      }
    }

    // ================================================================
    // Remove PDF
    // ================================================================

    if (pdfStoragePath != null) {
      try {
        log(
          '[$_tag] Rolling back uploaded pdf: '
          '$pdfStoragePath',
        );

        await supabase.storage.from('lesson-pdfs').remove([pdfStoragePath]);

        log('[$_tag] PDF rollback completed');
      } catch (e, st) {
        log(
          '[$_tag] PDF rollback FAILED: '
          '$pdfStoragePath',
          error: e,
          stackTrace: st,
        );
      }
    }
  }
}
