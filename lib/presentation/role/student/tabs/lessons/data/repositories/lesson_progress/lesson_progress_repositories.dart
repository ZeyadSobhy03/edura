import '../../model/lesson_progress/lesson_progress.dart';

abstract class LessonProgressRepositories {
  Future<void> createLessonProgress({required LessonProgressModel progress});

  Future<LessonProgressModel?> getLessonProgress(
      String lessonId,
      String studentId,
      );

  Future<void> updateLessonProgress({required LessonProgressModel progress});
}