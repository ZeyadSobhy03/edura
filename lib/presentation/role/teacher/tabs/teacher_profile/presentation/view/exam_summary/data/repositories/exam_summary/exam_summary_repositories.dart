

import '../../model/exam_summary/exam_summary.dart';

abstract class ExamSummaryRepositories {

  Future<List<ExamSummaryModel>> fetchExams();

  Future<List<StudentResultModel>> fetchResults(int examId);
}