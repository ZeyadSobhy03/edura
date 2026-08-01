class QuestionModel {
  final String id;
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;

  QuestionModel({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'].toString(),
      questionText: json['question_text'] ?? '',
      options: (json['options'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      correctOptionIndex: json['correct_option_index'] ?? 0,
    );
  }
}

class DummyQuestionData {
  static List<QuestionModel> calculusQuestions = [
    QuestionModel(
      id: 'q1',
      questionText: 'What is the derivative of f(x) = x³ + 2x² − 5x + 3?',
      options: ['3x² + 4x − 5', '3x² + 2x − 5', 'x² + 4x − 5', '3x + 4'],
      correctOptionIndex: 0,
    ),
    QuestionModel(
      id: 'q2',
      questionText: 'What is the integral of 2x dx?',
      options: ['x²', 'x² + C', '2x² + C', '2x'],
      correctOptionIndex: 1,
    ),
    QuestionModel(
      id: 'q3',
      questionText: 'What is the limit of (x² − 1)/(x − 1) as x approaches 1?',
      options: ['0', '1', '2', 'Undefined'],
      correctOptionIndex: 2,
    ),
  ];
}