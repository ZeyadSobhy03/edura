import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/lessons/new_lesson_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/repositories/lessons/teacher_lessons_repositories.dart';
import 'package:injectable/injectable.dart';


@injectable
class TeacherLessonsUseCase {
  final TeacherLessonsRepositories repositories;

  TeacherLessonsUseCase({required this.repositories});

  Future<Map<String, dynamic>> createLesson({required NewLessonModel lesson}) {
    return repositories.createLesson(lesson: lesson);
  }

  Future<List<LessonModel>> getLessons() {
    return repositories.getLessons();
  }

  Future<Map<String, dynamic>> updateLesson({
    required String lessonId,
    required NewLessonModel lesson,
    String? currentVideoUrl,
    String? currentPdfUrl,
  }) {
    return repositories.updateLesson(
      lessonId: lessonId,
      lesson: lesson,
      currentVideoUrl: currentVideoUrl,
      currentPdfUrl: currentPdfUrl,
    );
  }

  Future<void> deleteLesson({required String lessonId}) {
    return repositories.deleteLesson(lessonId: lessonId);
  }
}
