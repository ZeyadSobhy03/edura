import '../model/question_draft_model.dart';

abstract class ExamRepositories {
  Future<Map<String, dynamic>> createExam({
    required String title,
    required String subject,
    required int durationMinutes,
    required List<QuestionDraftModel> questions,
    required DateTime startDate,
    required DateTime endDate,
  });

}