
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/exam_summary/data/model/student_exam_review/student_exam_review.dart';

abstract class StudentExamReviewRepositories {

  Future<StudentReviewData> examReview(int examId, String studentId);

}