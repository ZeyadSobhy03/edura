import 'package:edura/core/extensions/date_ex.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/homework_submission_model.dart';
import '../../../../../../l10n/app_localizations.dart';

class SubmissionListCard extends StatelessWidget {
  const SubmissionListCard({
    super.key,
    required this.submission,
    required this.onTap,
  });

  final HomeworkSubmissionModel submission;
  final VoidCallback onTap;

  String get _initials {
    final parts = submission.studentName.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts.isNotEmpty ? parts[0][0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final isPending = submission.status == SubmissionStatus.pending;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: ColorManager.primary.withValues(alpha: 0.12),
                child: CustomText(
                  text: _initials,
                  style: TextStyle(
                    color: ColorManager.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: submission.studentName,
                      style: TextStyle(
                        color: ColorManager.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    CustomText(
                      text: submission.lessonTitle,
                      style: TextStyle(
                        color: ColorManager.primary,
                        fontSize: 12.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        CustomText(
                          text:
                              '${l10.submitted} ${submission.submittedAt.timeAgo(context)}',
                          style: TextStyle(
                            color: ColorManager.black.withValues(alpha: 0.5),
                            fontSize: 11.5,
                          ),
                        ),
                        if (!isPending && submission.grade != null) ...[
                          CustomText(
                            text: '  ·  ',
                            style: TextStyle(
                              color: ColorManager.black.withValues(alpha: 0.3),
                            ),
                          ),
                          CustomText(
                            text: l10.gradeValue(submission.grade!),
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: (isPending ? Colors.orange : Colors.green).withValues(
                    alpha: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomText(
                  text: isPending ? l10.pending : l10.graded,
                  style: TextStyle(
                    color: isPending ? Colors.orange : Colors.green,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          if (isPending) ...[
            const SizedBox(height: 12),
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: CustomText(
                  text: l10.tapToReviewAndGrade,
                  style: TextStyle(
                    color: ColorManager.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
