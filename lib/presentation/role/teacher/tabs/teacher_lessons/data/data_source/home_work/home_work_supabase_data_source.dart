import 'dart:io';

import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/data_source/home_work/home_work_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/home_work/new_homework_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/error/rethrow_as_app_error.dart';

class HomeWorkSupabaseDataSource implements HomeWorkRemoteDataSource {
  final supabase = Supabase.instance.client;

  // TODO: confirm these match your actual schema/bucket names
  static const String _table = 'homeworks';
  static const String _bucket = 'homework-attachments';

  @override
  Future<void> createHomework({
    required String lessonId,
    required NewHomeworkModel homework,
  }) async {
    try {
      final attachmentUrls = <String>[];
      for (final file in homework.attachments) {
        final fileName = file.path.split(Platform.pathSeparator).last;
        final storagePath =
            '$lessonId/${DateTime.now().millisecondsSinceEpoch}_$fileName';

        await supabase.storage.from(_bucket).upload(storagePath, file);

        final publicUrl = supabase.storage
            .from(_bucket)
            .getPublicUrl(storagePath);
        attachmentUrls.add(publicUrl);
      }

      await supabase.from(_table).insert({
        'lesson_id': lessonId,
        'title': homework.title,
        'description': homework.description,
        'subject': homework.subject,
        'due_date': homework.dueDate?.toIso8601String(),
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
          .update({'is_published': true})
          .eq('id', homeworkId);
    } catch (e) {
      rethrowAsAppError(e);
    }
  }
}
