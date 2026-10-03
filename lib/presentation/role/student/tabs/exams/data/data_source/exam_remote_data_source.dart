import '../../../../../../../core/model/exam_model.dart';
import '../model/student_question_model.dart';

abstract class ExamRemoteDataSource {


  Future<List<ExamModel>> fetchExams();
  Future<List<StudentQuestionModel>> startExam(String examId);
  Future<ExamResultModel> submitExam({
    required String attemptId,
    required Map<String, int> answers,
  });

}