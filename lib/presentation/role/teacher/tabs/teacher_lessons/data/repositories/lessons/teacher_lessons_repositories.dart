import 'package:edura/core/model/lesson_model.dart';

import '../../model/lessons/new_lesson_model.dart';

abstract class TeacherLessonsRepositories {
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
