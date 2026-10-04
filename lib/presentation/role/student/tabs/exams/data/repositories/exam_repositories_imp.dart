
import 'package:edura/core/model/exam_model.dart';
import 'package:edura/presentation/role/student/tabs/exams/data/data_source/exam_remote_data_source.dart';
import 'package:edura/presentation/role/student/tabs/exams/data/model/student_question.dart';
import 'package:edura/presentation/role/student/tabs/exams/data/model/student_question_model.dart';
import 'package:edura/presentation/role/student/tabs/exams/data/repositories/exam_repositories.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: ExamRepositories)
class ExamRepositoriesImp implements ExamRepositories {

  final ExamRemoteDataSource examRemoteDataSource;
  ExamRepositoriesImp({required this.examRemoteDataSource});

  @override
  Future<List<ExamModel>> fetchExams({required String studentId}) {
    return examRemoteDataSource.fetchExams(studentId: studentId);
  }

  @override
  Future<({String attemptId, List<StudentQuestionModel> questions})> startExam(String examId, {required String studentId}) {
    return examRemoteDataSource.startExam(examId, studentId: studentId);
  }

  @override
  Future<ExamResultModel> submitExam({required String attemptId, required String studentId, required Map<String, int> answers}) {
    return examRemoteDataSource.submitExam(attemptId: attemptId, studentId: studentId, answers: answers);
  }

  @override
  Future<List<ReviewQuestionModel>> fetchReview(String examId, {required String studentId}) {
    return examRemoteDataSource.fetchReview(examId, studentId: studentId);
  }

}