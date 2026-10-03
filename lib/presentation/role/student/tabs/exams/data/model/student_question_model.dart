class StudentQuestionModel {
  final String id;
  final String questionText;
  final List<String> options;

  const StudentQuestionModel({
    required this.id,
    required this.questionText,
    required this.options,
  });

  factory StudentQuestionModel.fromJson(Map<String, dynamic> json) =>
      StudentQuestionModel(
        id: json['id'].toString(),
        questionText: json['question_text'] ?? '',
        options: List<String>.from(json['options'] ?? []),
      );
}

class ExamResultModel {
  final double score;
  final bool passed;
  final int correctCount;
  final int totalCount;

  const ExamResultModel({
    required this.score,
    required this.passed,
    required this.correctCount,
    required this.totalCount,
  });

  factory ExamResultModel.fromJson(Map<String, dynamic> json) =>
      ExamResultModel(
        score: (json['score'] as num).toDouble(),
        passed: json['passed'] as bool,
        correctCount: json['correct_count'] as int,
        totalCount: json['total_count'] as int,
      );
}
