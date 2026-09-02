import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/new_lesson_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/repositories/teacher_lessons_repositories.dart';

import '../data_source/teacher_lessons_remote_data_source.dart';

class TeacherLessonsRepositoriesImp implements TeacherLessonsRepositories {


  final TeacherLessonsRemoteDataSource remoteDataSource;
  TeacherLessonsRepositoriesImp({required this.remoteDataSource});

  @override
  Future<Map<String, dynamic>> createLesson({required NewLessonModel lesson}) {
    return remoteDataSource.createLesson(lesson: lesson);
  }




}