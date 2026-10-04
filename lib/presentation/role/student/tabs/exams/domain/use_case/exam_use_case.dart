import 'package:edura/presentation/role/student/tabs/exams/data/repositories/exam_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/model/exam_model.dart';
import '../../data/model/student_question.dart';
import '../../data/model/student_question_model.dart';

@injectable
class ExamUseCase {
  final ExamRepositories examRepositories;

  ExamUseCase({required this.examRepositories});

  Future<List<ExamModel>> fetchExams({required String studentId}) {
    return examRepositories.fetchExams(studentId: studentId);
  }

  Future<({String attemptId, List<StudentQuestionModel> questions})> startExam(
    String examId, {
    required String studentId,
  }) {
    return examRepositories.startExam(examId, studentId: studentId);
  }

  Future<ExamResultModel> submitExam({
    required String attemptId,
    required String studentId,
    required Map<String, int> answers,
  }) {
    return examRepositories.submitExam(
      attemptId: attemptId,
      studentId: studentId,
      answers: answers,
    );
  }
  Future<List<ReviewQuestionModel>> fetchReview(
      String examId, {
        required String studentId,
      }){
    return examRepositories.fetchReview(examId, studentId: studentId);
  }
}
