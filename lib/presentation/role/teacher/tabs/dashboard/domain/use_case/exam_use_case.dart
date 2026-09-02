import 'package:edura/presentation/role/teacher/tabs/dashboard/data/repositories/exam_repositories.dart';

import '../../data/model/question_draft_model.dart';

class ExamUseCase {
  final ExamRepositories repositories;

  ExamUseCase({required this.repositories});

  Future<Map<String, dynamic>> createExam({
    required String title,
    required String subject,
    required int durationMinutes,
    required List<QuestionDraftModel> questions,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return repositories.createExam(
      title: title,
      subject: subject,
      durationMinutes: durationMinutes,
      questions: questions,
      endDate: endDate,
      startDate: startDate
    );
  }
}
