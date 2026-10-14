import '../../../../../../../../../student/tabs/exams/data/model/student_question.dart';

class StudentReviewData {
  final String studentName;
  final double score, maxScore;
  final DateTime? submittedAt;
  final List<ReviewQuestionModel> questions;

  StudentReviewData.fromJson(Map<String, dynamic> j)
    : studentName = j['student_name'] ?? '',
      score = (j['score'] as num?)?.toDouble() ?? 0,
      maxScore = (j['max_score'] as num?)?.toDouble() ?? 0,
      submittedAt = j['submitted_at'] != null
          ? DateTime.parse(j['submitted_at']).toLocal()
          : null,
      questions = (j['questions'] as List)
          .map(
            (q) => ReviewQuestionModel.fromJson(Map<String, dynamic>.from(q)),
          )
          .toList();

  double get percent => maxScore > 0 ? score / maxScore * 100 : 0;
}
