import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/repositories/teacher_lessons_repositories.dart';

import '../../data/model/new_lesson_model.dart';

class TeacherLessonsUseCase {
  final TeacherLessonsRepositories repositories;

  TeacherLessonsUseCase({required this.repositories});

  Future<Map<String, dynamic>> createLesson({required NewLessonModel lesson}) {
    return repositories.createLesson(lesson: lesson);
  }
}
