import 'dart:io';

import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/data_source/home_work/home_work_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/home_work/new_homework_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/error/rethrow_as_app_error.dart';
import '../../../../../../student/tabs/lessons/data/model/student_home_work/homework_submission_model.dart';

@LazySingleton(as: HomeWorkRemoteDataSource)
class HomeWorkSupabaseDataSource implements HomeWorkRemoteDataSource {
  final supabase = Supabase.instance.client;

  static const String _table = 'homeworks';
  static const String _bucket = 'homework-attachments';
  static const String homeworkSubmissions = "homework_submissions";
  static const String _submissionsBucket = 'homework-submissions';

  @override
  Future<void> createHomework({
    String? lessonId,
    required NewHomeworkModel homework,
  }) async {
    try {
      final teacherId = supabase.auth.currentUser?.id;
      if (teacherId == null) {
        throw Exception('No authenticated user');
      }

      final ownerFolder = lessonId ?? teacherId;

      final attachmentUrls = <String>[];
      for (final file in homework.attachments) {
        final fileName = file.path.split(Platform.pathSeparator).last;
        final storagePath =
            '$ownerFolder/${DateTime.now().millisecondsSinceEpoch}_$fileName';

        await supabase.storage.from(_bucket).upload(storagePath, file);

        final publicUrl = supabase.storage
            .from(_bucket)
            .getPublicUrl(storagePath);
        attachmentUrls.add(publicUrl);
      }

      await supabase.from(_table).insert({
        'lesson_id': ?lessonId,
        'title': homework.title,
        'teacher_id': teacherId,
        'description': homework.description,
        'subject': homework.subject,
        'status': homework.isPublished ? 'published' : 'draft',
        'due_date': homework.dueDate?.toUtc().toIso8601String(),
        'is_published': homework.isPublished,
        'attachments': attachmentUrls,
      });
    } catch (e) {
      rethrowAsAppError(e);
    }
  }

  @override
  Future<void> deleteHomework(String homeworkId) async {
    try {
      await supabase.from(_table).delete().eq('id', homeworkId);
    } catch (e) {
      rethrowAsAppError(e);
    }
  }

  @override
  Future<List<NewHomeworkModel>> getHomeworksByLesson(String lessonId) async {
    try {
      final response = await supabase
          .from(_table)
          .select()
          .eq('lesson_id', lessonId)
          .order('created_at', ascending: false);

      return (response as List<dynamic>)
          .map((row) => NewHomeworkModel.fromJson(row as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrowAsAppError(e);
    }
  }

  @override
  Future<void> publishHomework(String homeworkId) async {
    try {
      await supabase
          .from(_table)
          .update({'is_published': true, 'status': 'published'})
          .eq('id', homeworkId);
    } catch (e) {
      rethrowAsAppError(e);
    }
  }

  @override
  Future<void> reviewHomework(
    String submissionId,
    int grade,
    String feedback,
  ) async {
    try {
      final now = DateTime.now().toUtc().toIso8601String();
      await supabase
          .from(homeworkSubmissions)
          .update({
            'grade': grade,
            'feedback': feedback,
            'graded_at': now,
            'updated_at': now,
            'status': 'graded',
          })
          .eq('id', submissionId);
    } catch (e) {
      rethrowAsAppError(e);
    }
  }

  @override
  Future<List<NewHomeworkModel>> getAllHomeworks() async {
    try {
      final response = await supabase
          .from(_table)
          .select()
          .order('created_at', ascending: false);

      return (response as List<dynamic>)
          .map((row) => NewHomeworkModel.fromJson(row as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrowAsAppError(e);
    }
  }

  @override
  Future<List<HomeworkSubmissionModel>> getSubmissionsByHomework(
    String homeworkId,
  ) async {
    try {
      final response =
          await supabase.rpc(
                'get_homework_submissions',
                params: {'p_homework_id': homeworkId},
              )
              as List;

      final result = <HomeworkSubmissionModel>[];
      for (final r in response) {
        final data = Map<String, dynamic>.from(r);

        final filePath = data['file_url'] as String?;
        if (filePath != null && filePath.isNotEmpty) {
          try {
            data['file_url'] = await supabase.storage
                .from(_submissionsBucket)
                .createSignedUrl(filePath, 3600);
          } catch (e) {
            data['file_url'] = '';
          }
        }

        result.add(HomeworkSubmissionModel.fromJson(data));
      }
      return result;
    } catch (e) {
      rethrowAsAppError(e);
    }
  }
}
