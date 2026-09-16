import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/repositories/home_work/home_work_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/home_work/new_homework_model.dart';

@injectable
class HomeWorkUseCase {
  final HomeWorkRepositories homeWorkRepositories;
  HomeWorkUseCase({required this.homeWorkRepositories});
  Future<void> createHomework({
    String? lessonId,
    required NewHomeworkModel homework,
  }) {
    return homeWorkRepositories.createHomework(
      lessonId: lessonId,
      homework: homework,
    );
  }

  Future<List<NewHomeworkModel>> getHomeworksByLesson(String lessonId) {
    return homeWorkRepositories.getHomeworksByLesson(lessonId);
  }

  Future<void> publishHomework(String homeworkId) {
    return homeWorkRepositories.publishHomework(homeworkId);
  }

  Future<void> deleteHomework(String homeworkId) {
    return homeWorkRepositories.deleteHomework(homeworkId);
  }

  Future<void> reviewHomework(String submissionId, int grade, String feedback) {
    return homeWorkRepositories.reviewHomework(submissionId, grade, feedback);
  }
}
