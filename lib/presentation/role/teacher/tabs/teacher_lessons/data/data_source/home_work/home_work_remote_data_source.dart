import '../../../../../../student/tabs/lessons/data/model/student_home_work/homework_submission_model.dart';
import '../../model/home_work/new_homework_model.dart';

abstract class HomeWorkRemoteDataSource {
  Future<void> createHomework({
    String? lessonId,
    required NewHomeworkModel homework,
  });

  Future<List<NewHomeworkModel>> getHomeworksByLesson(String lessonId);

  Future<List<NewHomeworkModel>> getAllHomeworks();

  Future<void> publishHomework(String homeworkId);

  Future<void> deleteHomework(String homeworkId);

  Future<List<HomeworkSubmissionModel>> getSubmissionsByHomework(
    String homeworkId,
  );

  Future<void> reviewHomework(String submissionId, int grade, String feedback);
}
