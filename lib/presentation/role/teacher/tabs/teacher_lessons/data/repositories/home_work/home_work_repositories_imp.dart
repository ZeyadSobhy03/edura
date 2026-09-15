import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/home_work/new_homework_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/repositories/home_work/home_work_repositories.dart';

import '../../data_source/home_work/home_work_remote_data_source.dart';

class HomeWorkRepositoriesImp implements HomeWorkRepositories {
  final HomeWorkRemoteDataSource remoteDataSource;
  HomeWorkRepositoriesImp({required this.remoteDataSource});

  @override
  Future<void> createHomework({required String lessonId, required NewHomeworkModel homework}) {
    return remoteDataSource.createHomework(lessonId: lessonId, homework: homework);
  }

  @override
  Future<void> deleteHomework(String homeworkId) {
    return remoteDataSource.deleteHomework(homeworkId);
  }

  @override
  Future<List<NewHomeworkModel>> getHomeworksByLesson(String lessonId) {
    return remoteDataSource.getHomeworksByLesson(lessonId);
  }

  @override
  Future<void> publishHomework(String homeworkId) {
    return remoteDataSource.publishHomework(homeworkId);
  }
}