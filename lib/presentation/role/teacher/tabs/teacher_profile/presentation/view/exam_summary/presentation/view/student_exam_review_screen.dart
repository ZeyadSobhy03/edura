import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/presentation/role/student/tabs/exams/presentation/view/exam_details/section/question_card.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/exam_summary/presentation/view_model/student_exam_review/student_exam_review_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../core/model/student_exam_review_args.dart';
import '../../../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../../student/tabs/exams/presentation/view/exam_details/section/answer_option_tile.dart';

class StudentExamReviewScreen extends StatefulWidget {
  const StudentExamReviewScreen({super.key, required this.args});

  final StudentExamReviewArgs args;

  @override
  State<StudentExamReviewScreen> createState() =>
      _StudentExamReviewScreenState();
}

class _StudentExamReviewScreenState extends State<StudentExamReviewScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StudentExamReviewCubit>().load(
      widget.args.examId,
      widget.args.studentId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    const labels = ['A', 'B', 'C', 'D', 'E', 'F'];

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: Text(widget.args.studentName),
        backgroundColor: ColorManager.white,
      ),
      body: BlocBuilder<StudentExamReviewCubit, StudentReviewState>(
        builder: (context, state) {
          if (state is StudentReviewLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          }
          if (state is StudentReviewError) {
            return Center(child: Text(state.message));
          }
          final d = (state as StudentReviewLoaded).data;
          final passed = d.percent >= 60;
          final color = passed ? Colors.green : Colors.red;

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: color.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${d.percent.toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text('${d.score.toInt()} / ${d.maxScore.toInt()}'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ...List.generate(d.questions.length, (i) {
                  final q = d.questions[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QuestionCard(
                          questionNumber: i + 1,
                          questionText: q.questionText,
                        ),
                        const SizedBox(height: 12),
                        if (q.selectedIndex == null)
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              l10.notAnswered,
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                        ...List.generate(q.options.length, (o) {
                          OptionReviewState s;
                          if (o == q.correctOptionIndex) {
                            s = OptionReviewState.correct;
                          } else if (o == q.selectedIndex) {
                            s = OptionReviewState.incorrectSelected;
                          } else {
                            s = OptionReviewState.none;
                          }
                          return AnswerOptionTile(
                            label: labels[o],
                            text: q.options[o],
                            isSelected: o == q.selectedIndex,
                            onTap: null,
                            reviewState: s,
                          );
                        }),
                      ],
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
