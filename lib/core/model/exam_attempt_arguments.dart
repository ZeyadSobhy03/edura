import 'package:edura/core/model/exam_model.dart';
import 'package:edura/core/model/question_model.dart';

class ExamAttemptArguments {
  final ExamModel exam;
  final List<QuestionModel> questions;

  ExamAttemptArguments({
    required this.exam,
    required this.questions,
  });
}