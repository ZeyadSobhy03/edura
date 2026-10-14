
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/exam_summary/data/model/exam_summary/exam_summary.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/exam_summary/data/repositories/exam_summary/exam_summary_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/exam_summary/exam_summary_remote_data_source.dart';
@LazySingleton(as: ExamSummaryRepositories)
class ExamSummaryRepositoriesImp implements ExamSummaryRepositories {
  final ExamSummaryRemoteDataSource remoteDataSource;
  ExamSummaryRepositoriesImp({required this.remoteDataSource});

  @override
  Future<List<ExamSummaryModel>> fetchExams() {
    return remoteDataSource.fetchExams();
  }

  @override
  Future<List<StudentResultModel>> fetchResults(int examId) {
    return remoteDataSource.fetchResults(examId);
  }
}