import 'dart:io';

import 'package:edura/presentation/role/student/tabs/lessons/data/repositories/student_home_work/student_home_work_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/student_home_work/homework_submission_model.dart';

@injectable
class StudentHomeWorkUseCase {
  final StudentHomeWorkRepositories repositories;

  StudentHomeWorkUseCase({required this.repositories});

  Future<HomeworkSubmissionModel> submit({
    required String homeworkId,
    required String studentId,
    required File file,
    DateTime? dueDate,
  }) {
    return repositories.submit(
      homeworkId: homeworkId,
      studentId: studentId,
      file: file,
      dueDate: dueDate,
    );
  }

  Future<HomeworkSubmissionModel?> getMySubmission(
    String homeworkId,
    String studentId,
  ) {
    return repositories.getMySubmission(homeworkId, studentId);
  }

  Future<List<HomeworkSubmissionModel>> getSubmissionsForHomework(
    String homeworkId,
    String studentId,
  ) {
    return repositories.getSubmissionsForHomework(homeworkId, studentId);
  }
}
