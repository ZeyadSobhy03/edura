import 'dart:io';

import 'package:edura/presentation/role/student/tabs/lessons/data/data_source/student_home_work/student_home_work_remote_data_source.dart';
import 'package:edura/presentation/role/student/tabs/lessons/data/model/student_home_work/homework_submission_model.dart';
import 'package:edura/presentation/role/student/tabs/lessons/data/repositories/student_home_work/student_home_work_repositories.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: StudentHomeWorkRepositories)
class StudentHomeWorkRepositoriesImp implements StudentHomeWorkRepositories {
  final StudentHomeWorkRemoteDataSource remoteDataSource;

  StudentHomeWorkRepositoriesImp({required this.remoteDataSource});

  @override
  Future<HomeworkSubmissionModel?> getMySubmission(
    String homeworkId,
    String studentId,
  ) {
    return remoteDataSource.getMySubmission(homeworkId, studentId);
  }

  @override
  Future<List<HomeworkSubmissionModel>> getSubmissionsForHomework(
    String homeworkId,
    String studentId,
  ) {
    return remoteDataSource.getSubmissionsForHomework(homeworkId, studentId);
  }

  @override
  Future<HomeworkSubmissionModel> submit({
    required String homeworkId,
    required String studentId,
    required File file,
    DateTime? dueDate,
  }) {
    return remoteDataSource.submit(
      homeworkId: homeworkId,
      studentId: studentId,
      file: file,
    );
  }
}
