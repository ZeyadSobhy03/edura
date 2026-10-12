import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/role/student/tabs/lessons/data/model/student_home_work/homework_submission_model.dart';
import 'package:flutter/material.dart';

class BuildSubmittedView extends StatelessWidget {
  const BuildSubmittedView({
    super.key,
    required this.onResubmit,
    this.submission,
  });

  final VoidCallback onResubmit;
  final HomeworkSubmissionModel? submission;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final s = submission;
    final graded = s != null && s.grade != null;
    final feedback = s?.feedback?.trim() ?? '';
    final color = graded ? Colors.green : Colors.orange;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                graded ? Icons.check_circle : Icons.hourglass_top,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomText(
                  text: graded ? l10.graded : l10.submitted,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              if (graded)
                CustomText(
                  text: l10.gradeValue(s.grade!),
                  style: TextStyle(
                    color: ColorManager.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
            ],
          ),
          if (graded && feedback.isNotEmpty) ...[
            const SizedBox(height: 10),
            CustomText(
              text: l10.feedback,
              style: TextStyle(
                color: ColorManager.black.withValues(alpha: 0.5),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            CustomText(
              text: feedback,
              style: TextStyle(color: ColorManager.black, fontSize: 13),
            ),
          ],
          if (!graded) ...[
            const SizedBox(height: 10),
            TextButton(
              onPressed: onResubmit,
              child:  Text(l10.resubmitHomework),
            ),
          ],
        ],
      ),
    );
  }
}