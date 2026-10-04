import 'package:edura/core/model/exam_model.dart';
import 'package:edura/presentation/role/student/tabs/exams/data/model/student_question_model.dart';

import '../model/student_question.dart';

abstract class ExamRemoteDataSource {
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
