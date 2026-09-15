import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/lessons/new_lesson_model.dart';

abstract class TeacherLessonsRemoteDataSource {
  Future<Map<String, dynamic>> createLesson({required NewLessonModel lesson});

  Future<List<LessonModel>> getLessons();

  Future<Map<String, dynamic>> updateLesson({
    required String lessonId,
    required NewLessonModel lesson,
    String? currentVideoUrl,
    String? currentPdfUrl,
  });

  Future<void> deleteLesson({required String lessonId});
}
