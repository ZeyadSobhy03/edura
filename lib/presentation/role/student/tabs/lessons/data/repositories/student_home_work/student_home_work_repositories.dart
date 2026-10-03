import 'dart:io';

import '../../model/student_home_work/homework_submission_model.dart';

abstract class StudentHomeWorkRepositories {
  Future<HomeworkSubmissionModel> submit({
    required String homeworkId,
    required String studentId,
    required File file,
    DateTime? dueDate,
  });

  Future<HomeworkSubmissionModel?> getMySubmission(String homeworkId, String studentId);

  Future<List<HomeworkSubmissionModel>> getSubmissionsForHomework(
      String homeworkId,
      String studentId,
      );
}