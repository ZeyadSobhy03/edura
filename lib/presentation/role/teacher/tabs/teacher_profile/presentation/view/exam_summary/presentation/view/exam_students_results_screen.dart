import 'package:edura/core/model/student_exam_review_args.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/exam_summary/presentation/view_model/student_results/student_results_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../../../l10n/app_localizations.dart';
import '../../data/model/exam_summary/exam_summary.dart';

class ExamStudentsResultsScreen extends StatefulWidget {
  const ExamStudentsResultsScreen({super.key, required this.exam});

  final ExamSummaryModel exam;

  @override
  State<ExamStudentsResultsScreen> createState() =>
      _ExamStudentsResultsScreenState();
}

class _ExamStudentsResultsScreenState extends State<ExamStudentsResultsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StudentResultsCubit>().loadResults(widget.exam.id);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: Text(widget.exam.title),
        backgroundColor: ColorManager.white,
      ),
      body: BlocBuilder<StudentResultsCubit, StudentResultsState>(
        builder: (context, state) {
          if (state is StudentResultsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          }
          if (state is StudentResultsError) {
            return Center(child: Text(state.message));
          }
          final results = (state as StudentResultsLoaded).results;
          if (results.isEmpty) {
            return Center(child: Text(l10.noStudentsStartedExam));
          }
          return SafeArea(
            child: RefreshIndicator(
              color: ColorManager.primary,
              backgroundColor: ColorManager.white,
              onRefresh: () =>
                  context.read<StudentResultsCubit>().loadResults(widget.exam.id),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: results.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final r = results[i];
                  final color = !r.isSubmitted
                      ? Colors.orange
                      : (r.passed ? Colors.green : Colors.red);
                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: r.isSubmitted
                        ? () => Navigator.pushNamed(
                            context,
                            RouteManger.studentExamReviewScreen,
                            arguments: StudentExamReviewArgs(
                              studentId: r.studentId,
                              studentName: r.name,
                              examId: widget.exam.id,
                            ),
                          )
                        : null,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: color.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  r.isSubmitted
                                      ? DateFormat(
                                          'MMM d, h:mm a',
                                        ).format(r.submittedAt!)
                                      : l10.inProgress,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ColorManager.black.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (r.isSubmitted)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${r.percent.toStringAsFixed(0)}%',
                                  style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  '${r.score.toInt()}/${r.maxScore.toInt()}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
