import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/exam_summary/data/repositories/exam_summary/exam_summary_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/exam_summary/exam_summary.dart';

@injectable
class ExamSummaryUseCase {
  final ExamSummaryRepositories repositories;

  ExamSummaryUseCase({required this.repositories});

  Future<List<ExamSummaryModel>> fetchExams() {
    return repositories.fetchExams();
  }

  Future<List<StudentResultModel>> fetchResults(int examId) {
    return repositories.fetchResults(examId);
  }
}
