

import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/exam_summary/data/model/student_exam_review/student_exam_review.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/exam_summary/data/repositories/student_exam_review/student_exam_review_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/student_exam_review/student_exam_review_remote_data_source.dart';
@LazySingleton(as: StudentExamReviewRepositories)
class StudentExamReviewRepositoriesImp implements StudentExamReviewRepositories {
  final StudentExamReviewRemoteDataSource remoteDataSource;
  StudentExamReviewRepositoriesImp({required this.remoteDataSource});

  @override
  Future<StudentReviewData> examReview(int examId, String studentId) {
    return remoteDataSource.examReview(examId, studentId);
  }

}