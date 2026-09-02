import 'package:edura/presentation/role/teacher/tabs/dashboard/data/data_source/exam_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/question_draft_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/repositories/exam_repositories.dart';

class ExamRepositoriesImp implements ExamRepositories {
  final ExamRemoteDataSource remoteDataSource;

  ExamRepositoriesImp({required this.remoteDataSource});

  @override
  Future<Map<String, dynamic>> createExam({
    required String title,
    required String subject,
    required int durationMinutes,
    required List<QuestionDraftModel> questions,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return remoteDataSource.createExam(
      title: title,
      subject: subject,
      durationMinutes: durationMinutes,
      questions: questions,
      endDate: endDate,
      startDate: startDate
    );
  }
}
