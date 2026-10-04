import 'package:edura/core/model/exam_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/student/tabs/exams/data/model/student_question_model.dart';
import 'package:edura/presentation/role/student/tabs/exams/presentation/view/exam_details/section/question_card.dart';
import 'package:edura/presentation/role/student/tabs/exams/presentation/view_model/exam_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../core/resources/routes/route_manger.dart';
import '../../../../../../../../../l10n/app_localizations.dart';
import 'answer_option_tile.dart';

class ExamResultScreen extends StatefulWidget {
  const ExamResultScreen({
    super.key,
    required this.exam,
    required this.result,
  });

  final ExamModel exam;
  final ExamResultModel result;

  @override
  State<ExamResultScreen> createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends State<ExamResultScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StudentExamCubit>().fetchReview(widget.exam.id);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final result = widget.result;
    final passed = result.passed;
    final color = passed ? Colors.green : Colors.red;
    final optionLabels = ['A', 'B', 'C', 'D', 'E', 'F'];

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: CustomText(
            text: widget.exam.title,
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
              Expanded(
                child: BlocBuilder<StudentExamCubit, ExamState>(
                  builder: (context, state) {
                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        // Score summary
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(16),
                            border:
                            Border.all(color: color.withValues(alpha: 0.3)),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                passed
                                    ? Icons.emoji_events
                                    : Icons.info_outline,
                                color: color,
                                size: 40,
                              ),
                              const SizedBox(height: 8),
                              CustomText(
                                text: '${result.score.toStringAsFixed(0)}%',
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              CustomText(
                                text: l10.correctAnswersSummary(
                                  result.correctCount,
                                  result.totalCount,
                                ),
                                style: TextStyle(
                                  color:
                                  ColorManager.black.withValues(alpha: 0.6),
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: CustomText(
                                  text: passed ? l10.passed : l10.failed,
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

                        // Review
                        if (state is ExamError)
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Center(child: Text(state.message)),
                          )
                        else if (state is! ExamReview)
                          const Padding(
                            padding: EdgeInsets.all(24),
                            child: Center(
                              child: CircularProgressIndicator(
                                  color: ColorManager.primary),
                            ),
                          )
                        else
                          ...List.generate(state.questions.length, (index) {
                            final q = state.questions[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  QuestionCard(
                                    questionNumber: index + 1,
                                    questionText: q.questionText,
                                  ),
                                  const SizedBox(height: 12),
                                  ...List.generate(q.options.length, (i) {
                                    OptionReviewState reviewState;
                                    if (i == q.correctOptionIndex) {
                                      reviewState = OptionReviewState.correct;
                                    } else if (i == q.selectedIndex) {
                                      reviewState =
                                          OptionReviewState.incorrectSelected;
                                    } else {
                                      reviewState = OptionReviewState.none;
                                    }
                                    return AnswerOptionTile(
                                      label: optionLabels[i],
                                      text: q.options[i],
                                      isSelected: i == q.selectedIndex,
                                      onTap: null,
                                      reviewState: reviewState,
                                    );
                                  }),
                                ],
                              ),
                            );
                          }),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteManger.studentMainLayoutRoute,
                            (route) => false,
                        arguments: 2,
                      );
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
                      style: const TextStyle(
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
      ),
    );
  }
}