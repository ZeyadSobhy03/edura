import '../model/new_lesson_model.dart';

abstract class TeacherLessonsRepositories {
  Future<Map<String, dynamic>>createLesson({required NewLessonModel lesson});


}