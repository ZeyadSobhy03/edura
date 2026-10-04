import '../../../../../../../core/model/exam_model.dart';
import '../model/student_question.dart';
import '../model/student_question_model.dart';

abstract class ExamRepositories {
  Future<List<ExamModel>> fetchExams({required String studentId});

  Future<({String attemptId, List<StudentQuestionModel> questions})> startExam(
      String examId, {
        required String studentId,
      });

  Future<ExamResultModel> submitExam({
    required String attemptId,
    required String studentId,
    required Map<String, int> answers,
  });
  Future<List<ReviewQuestionModel>> fetchReview(
      String examId, {
        required String studentId,
      });

}