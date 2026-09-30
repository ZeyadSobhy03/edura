import 'package:edura/presentation/role/student/tabs/lessons/data/repositories/lesson_progress_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/lesson_progress.dart';

@injectable
class LessonProgressUseCase {

  final LessonProgressRepositories lessonProgressRepositories;
  LessonProgressUseCase({required this.lessonProgressRepositories});
  Future<void> createLessonProgress({required LessonProgressModel progress}){
    return lessonProgressRepositories.createLessonProgress(progress: progress);
  }

  Future<LessonProgressModel?> getLessonProgress(
      String lessonId,
      String studentId,
      ){
    return lessonProgressRepositories.getLessonProgress(lessonId, studentId);
  }


  Future<void> updateLessonProgress({required LessonProgressModel progress}){
    return lessonProgressRepositories.updateLessonProgress(progress: progress);
  }

}