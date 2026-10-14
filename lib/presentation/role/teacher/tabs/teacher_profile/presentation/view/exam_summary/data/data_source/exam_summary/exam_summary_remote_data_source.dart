import '../../model/exam_summary/exam_summary.dart';

abstract class ExamSummaryRemoteDataSource {
  Future<List<ExamSummaryModel>> fetchExams();

  Future<List<StudentResultModel>> fetchResults(int examId);
}
