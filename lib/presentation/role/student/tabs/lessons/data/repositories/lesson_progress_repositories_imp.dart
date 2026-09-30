import 'package:edura/presentation/role/student/tabs/lessons/data/model/lesson_progress.dart';
import 'package:edura/presentation/role/student/tabs/lessons/data/repositories/lesson_progress_repositories.dart';
import 'package:injectable/injectable.dart';

import '../data_source/lesson_progress_remote_data_source.dart';
@LazySingleton(as: LessonProgressRepositories)
class LessonProgressRepositoriesImp implements LessonProgressRepositories {
  final LessonProgressRemoteDataSource remoteDataSource;
  LessonProgressRepositoriesImp({required this.remoteDataSource});

  @override
  Future<void> createLessonProgress({required LessonProgressModel progress}) {
    return remoteDataSource.createLessonProgress(progress: progress);
  }

  @override
  Future<LessonProgressModel?> getLessonProgress(String lessonId, String studentId) {
    return remoteDataSource.getLessonProgress(lessonId, studentId);
  }

  @override
  Future<void> updateLessonProgress({required LessonProgressModel progress}) {
    return remoteDataSource.updateLessonProgress(progress: progress);
  }
}