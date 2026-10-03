
import 'dart:developer';

import 'package:edura/presentation/role/student/tabs/lessons/data/data_source/lesson_progress/lesson_progress_remote_data_source.dart';
import 'package:edura/presentation/role/student/tabs/lessons/data/model/lesson_progress/lesson_progress.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/error/app_error.dart';

@LazySingleton(as: LessonProgressRemoteDataSource)
class LessonProgressSupabaseDataSource
    implements LessonProgressRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<void> createLessonProgress({
    required LessonProgressModel progress,
  }) async {
    try {
      await supabase.from('student_lesson_progress').insert({
        'lesson_id': progress.lessonId,
        'student_id': progress.studentId,
        'progress': progress.progress,
      });
    } on AppError{
      rethrow;
    } catch (e) {
      log('Error creating lesson progress: $e');
      throw ServerError();
    }
  }


  @override
  Future<LessonProgressModel?> getLessonProgress(
      String lessonId,
      String studentId,
      ) async {
    try {
      final response = await supabase
          .from('student_lesson_progress')
          .select()
          .eq('lesson_id', lessonId)
          .eq('student_id', studentId)
          .maybeSingle();

      if (response == null) {
        return null;
      }

      return LessonProgressModel.fromJson(response);
    } on AppError{
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }

  @override
  Future<void> updateLessonProgress({
    required LessonProgressModel progress,
  }) async {
    try {
      await supabase
          .from('student_lesson_progress')
          .update({'progress': progress.progress})
          .eq('lesson_id', progress.lessonId)
          .eq('student_id', progress.studentId);
    } on AppError {
      rethrow;
    } catch (e) {
      log('Error updating lesson progress: $e');
      throw ServerError();
    }
  }
}
