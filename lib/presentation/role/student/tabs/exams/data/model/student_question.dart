class ReviewQuestionModel {
  final String id;
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;
  final int? selectedIndex;

  const ReviewQuestionModel({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
    this.selectedIndex,
  });

  factory ReviewQuestionModel.fromJson(Map<String, dynamic> json) =>
      ReviewQuestionModel(
        id: json['id'].toString(),
        questionText: json['question_text'] ?? '',
        options: List<String>.from(json['options'] ?? []),
        correctOptionIndex: json['correct_option_index'] as int,
        selectedIndex: json['selected_index'] as int?,
      );
}