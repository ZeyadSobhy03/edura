import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/exam_summary/presentation/view_model/exam_summary/exam_summary_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../l10n/app_localizations.dart';

class TeacherExamResultsScreen extends StatefulWidget {
  const TeacherExamResultsScreen({super.key});

  @override
  State<TeacherExamResultsScreen> createState() => _TeacherExamResultsScreenState();
}

class _TeacherExamResultsScreenState extends State<TeacherExamResultsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExamSummaryCubit>().loadExams();
  }
  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: Text(l10.examsResults),
        backgroundColor: ColorManager.white,
      ),
      body: BlocBuilder<ExamSummaryCubit, ExamSummaryState>(
        builder: (context, state) {
          if (state is ExamSummaryLoading) {
            return const Center(child: CircularProgressIndicator(
              color: ColorManager.primary,
            ));
          }
          if (state is ExamSummaryError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: ColorManager.red),
              ),
            );
          }
          final exams = (state as ExamsSummaryLoaded).exams;
          if (exams.isEmpty) {
            return Center(
              child: Text(
                l10.noExamsFound,
                style: TextStyle(
                  color: ColorManager.black.withValues(alpha: 0.5),
                ),
              ),
            );
          }
          return SafeArea(
            child: RefreshIndicator(
              color: ColorManager.primary,
              backgroundColor: ColorManager.white,
              onRefresh: () => context.read<ExamSummaryCubit>().loadExams(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: exams.length,
                itemBuilder: (context, i) {
                  final e = exams[i];
                  return InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => Navigator.pushNamed(context, RouteManger.examStudentsResultsScreen , arguments: e),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: ColorManager.gray.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${e.subject}${e.grade.isEmpty ? '' : ' · ${e.grade}'}',
                            style: TextStyle(color: ColorManager.primary),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            children: [
                              _chip(l10.submittedCount(e.submitted), Colors.green),
                              if (e.inProgress > 0)
                                _chip(
                                  l10.inProgressCount(e.inProgress),
                                  Colors.orange,
                                ),
                              _chip(
                                e.avgPercent == null
                                    ? l10.avgPlaceholder
                                    : l10.avgLabel(e.avgPercent!.round()),
                                Colors.blue,
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

Widget _chip(String text, Color color) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  decoration: BoxDecoration(
    color: color.withValues(alpha: 0.1),
    borderRadius: BorderRadius.circular(20),
  ),
  child: Text(
    text,
    style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
  ),
);
