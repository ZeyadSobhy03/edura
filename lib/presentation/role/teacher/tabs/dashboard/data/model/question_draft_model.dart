class QuestionDraftModel {
  String questionText;
  List<String> options;
  int? correctOptionIndex;

  QuestionDraftModel({
    this.questionText = '',
    List<String>? options,
    this.correctOptionIndex,
  }) : options = options ?? ['', '', '', ''];

  bool get isValid =>
      questionText.trim().isNotEmpty &&
      options.every((o) => o.trim().isNotEmpty) &&
      correctOptionIndex != null;
}
