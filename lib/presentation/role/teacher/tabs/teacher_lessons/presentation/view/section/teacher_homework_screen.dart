import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view/section/review_homework_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/model/homework_submission_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../widgets/homework_stat_card.dart';
import '../widgets/submission_list_card.dart';


class TeacherHomeworkScreen extends StatelessWidget {
  const TeacherHomeworkScreen({super.key, required this.submissions});

  final List<HomeworkSubmissionModel> submissions;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final pending = submissions.where((s) => s.status == SubmissionStatus.pending).toList();
    final graded = submissions.where((s) => s.status == SubmissionStatus.graded).toList();

    final sorted = [...pending, ...graded];

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.homework,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: HomeworkStatCard(
                      count: pending.length,
                      label: l10.pendingReview,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: HomeworkStatCard(
                      count: graded.length,
                      label: l10.graded,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              CustomText(
                text: l10.submissions,
                style: TextStyle(
                  color: ColorManager.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              if (sorted.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: CustomText(
                      text: l10.noSubmissionsYet,
                      style: TextStyle(color: ColorManager.black.withValues(alpha: 0.5)),
                    ),
                  ),
                )
              else
                ...sorted.map((submission) {
                  return SubmissionListCard(
                    submission: submission,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReviewHomeworkScreen(submission: submission),
                        ),
                      );
                    },
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}