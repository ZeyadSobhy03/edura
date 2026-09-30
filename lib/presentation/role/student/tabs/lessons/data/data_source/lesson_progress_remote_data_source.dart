import 'package:edura/presentation/role/student/tabs/lessons/data/model/lesson_progress.dart';

abstract class LessonProgressRemoteDataSource {
  Future<void> createLessonProgress({required LessonProgressModel progress});

  Future<LessonProgressModel?> getLessonProgress(
    String lessonId,
    String studentId,
  );

  Future<void> updateLessonProgress({required LessonProgressModel progress});
}
