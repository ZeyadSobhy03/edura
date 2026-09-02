import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/new_lesson_model.dart';

abstract class TeacherLessonsRemoteDataSource {
  Future<Map<String, dynamic>> createLesson({required NewLessonModel lesson});
}
