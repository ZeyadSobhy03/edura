import '../../model/home_work/new_homework_model.dart';

abstract class HomeWorkRepositories {
  Future<void> createHomework({
    String? lessonId,
    required NewHomeworkModel homework,
  });

  Future<List<NewHomeworkModel>> getHomeworksByLesson(String lessonId);
  Future<void> publishHomework(String homeworkId);

  Future<void> deleteHomework(String homeworkId);
  Future<void> reviewHomework(String submissionId, int grade, String feedback);
}
