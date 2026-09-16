import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/data_source/lessons/teacher_lessons_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/lessons/new_lesson_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/repositories/lessons/teacher_lessons_repositories.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: TeacherLessonsRepositories)
class TeacherLessonsRepositoriesImp implements TeacherLessonsRepositories {
  final TeacherLessonsRemoteDataSource remoteDataSource;

  TeacherLessonsRepositoriesImp({required this.remoteDataSource});

  @override
  Future<Map<String, dynamic>> createLesson({required NewLessonModel lesson}) {
    return remoteDataSource.createLesson(lesson: lesson);
  }

  @override
  Future<List<LessonModel>> getLessons() {
    return remoteDataSource.getLessons();
  }

  @override
  Future<Map<String, dynamic>> updateLesson({
    required String lessonId,
    required NewLessonModel lesson,
    String? currentVideoUrl,
    String? currentPdfUrl,
  }) {
    return remoteDataSource.updateLesson(
      lessonId: lessonId,
      lesson: lesson,
      currentVideoUrl: currentVideoUrl,
      currentPdfUrl: currentPdfUrl,
    );
  }

  @override
  Future<void> deleteLesson({required String lessonId}) {
    return remoteDataSource.deleteLesson(lessonId: lessonId);
  }
}
