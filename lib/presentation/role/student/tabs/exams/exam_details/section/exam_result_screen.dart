import 'package:edura/core/model/exam_model.dart';
import 'package:edura/core/model/question_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/student/tabs/exams/exam_details/section/question_card.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/resources/routes/route_manger.dart';
import '../../../../../../../l10n/app_localizations.dart';
import 'answer_option_tile.dart';

class ExamResultScreen extends StatelessWidget {
  const ExamResultScreen({
    super.key,
    required this.exam,
    required this.questions,
    required this.selectedAnswers,
  });

  final ExamModel exam;
  final List<QuestionModel> questions;
  final Map<int, int> selectedAnswers; // questionIndex -> selectedOptionIndex

  int get _correctCount {
    int count = 0;
    for (var i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctOptionIndex) count++;
    }
    return count;
  }

  double get _scorePercent =>
      questions.isEmpty ? 0 : (_correctCount / questions.length) * 100;

  bool get _passed => _scorePercent >= 60;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final optionLabels = ['A', 'B', 'C', 'D', 'E', 'F'];

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: CustomText(
          text: exam.title,
          style: TextStyle(
            color: ColorManager.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: (_passed ? Colors.green : Colors.red).withValues(
                  alpha: 0.08,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: (_passed ? Colors.green : Colors.red).withValues(
                    alpha: 0.3,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    _passed ? Icons.emoji_events : Icons.info_outline,
                    color: _passed ? Colors.green : Colors.red,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    text: '${_scorePercent.toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    text: l10.correctAnswersSummary(
                      _correctCount,
                      questions.length,
                    ),
                    style: TextStyle(
                      color: ColorManager.black.withValues(alpha: 0.6),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _passed ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomText(
                      text: _passed ? l10.passed : l10.failed,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Review list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  final selected = selectedAnswers[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QuestionCard(
                          questionNumber: index + 1,
                          questionText: question.questionText,
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(question.options.length, (optIndex) {
                          OptionReviewState state;
                          if (optIndex == question.correctOptionIndex) {
                            state = OptionReviewState.correct;
                          } else if (optIndex == selected) {
                            state = OptionReviewState.incorrectSelected;
                          } else {
                            state = OptionReviewState.none;
                          }

                          return AnswerOptionTile(
                            label: optionLabels[optIndex],
                            text: question.options[optIndex],
                            isSelected: optIndex == selected,
                            onTap: null,
                            reviewState: state,
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Done button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, RouteManger.studentMainLayoutRoute, arguments: 2);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    l10.done,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
