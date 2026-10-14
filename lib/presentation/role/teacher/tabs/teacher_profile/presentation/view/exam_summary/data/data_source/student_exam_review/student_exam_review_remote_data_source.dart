import '../../model/student_exam_review/student_exam_review.dart';

abstract class StudentExamReviewRemoteDataSource {
  Future<StudentReviewData> examReview(int examId, String studentId);
}
