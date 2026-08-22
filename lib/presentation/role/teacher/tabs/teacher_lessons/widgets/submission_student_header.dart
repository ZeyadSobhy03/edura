import 'package:edura/core/extensions/date_ex.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/homework_submission_model.dart';

class SubmissionStudentHeader extends StatelessWidget {
  const SubmissionStudentHeader({super.key, required this.submission});

  final HomeworkSubmissionModel submission;

  String get _initials {
    final parts = submission.studentName.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts.isNotEmpty ? parts[0][0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: ColorManager.primary.withValues(alpha: 0.12),
            child: CustomText(
              text: _initials,
              style: TextStyle(
                color: ColorManager.primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: submission.studentName,
                  style: TextStyle(
                    color: ColorManager.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                CustomText(
                  text: submission.lessonTitle,
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.6),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                CustomText(
                  text: submission.submittedAt.timeAgo(context),
                  style: TextStyle(
                    color: ColorManager.primary.withValues(alpha: 0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
