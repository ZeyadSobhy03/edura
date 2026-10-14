import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/exam_summary/data/model/student_exam_review/student_exam_review.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/exam_summary/data/repositories/student_exam_review/student_exam_review_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class StudentExamReviewUseCase {
  final StudentExamReviewRepositories repositories;

  StudentExamReviewUseCase({required this.repositories});

  Future<StudentReviewData> examReview(int examId, String studentId) {
    return repositories.examReview(examId, studentId);
  }
}
