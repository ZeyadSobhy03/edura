import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/helper/exam_status_style.dart';
import '../../../../../../core/model/exam_model.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../widgets/exam_info_chip.dart';

class CustomExamCard extends StatelessWidget {
  const CustomExamCard({
    super.key,
    required this.exam,
    this.onStart,
  });

  final ExamModel exam;
  final VoidCallback? onStart;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final statusStyle = ExamStatusStyle.of(exam.status, l10);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomText(
                  text: exam.title,
                  style: TextStyle(
                    color: ColorManager.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusStyle.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomText(
                  text: statusStyle.label,
                  style: TextStyle(
                    color: statusStyle.color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: CustomText(
              text: exam.subject,
              style: const TextStyle(color: Colors.blue, fontSize: 11),
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              ExamInfoChip(
                icon: Icons.access_time,
                label: '${exam.durationMinutes}${l10.min}',
              ),
              ExamInfoChip(
                icon: Icons.description_outlined,
                label: '${exam.questionsCount} ${l10.questions}',
              ),
              ExamInfoChip(
                icon: Icons.calendar_today_outlined,
                label: DateFormat('MMM d',locale).format(exam.date),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _buildBottomAction(context, l10),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context, AppLocalizations l10) {
    switch (exam.status) {
      case ExamStatus.available:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onStart,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              l10.startExam,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        );

      case ExamStatus.completed:
        final passed = exam.passed ?? false;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: (passed ? Colors.green : Colors.red).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                passed ? Icons.check_circle : Icons.cancel,
                size: 18,
                color: passed ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 6),
              CustomText(
                text: '${exam.score?.toStringAsFixed(0) ?? '--'}% · ',
                style: TextStyle(
                  color: ColorManager.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomText(
                text: passed ? l10.passed : l10.failed,
                style: TextStyle(
                  color: passed ? Colors.green : Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );

      case ExamStatus.upcoming:
        return const SizedBox.shrink();

      case ExamStatus.locked:
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: ColorManager.gray.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock, size: 16, color: ColorManager.gray),
              const SizedBox(width: 6),
              CustomText(
                text: l10.locked,
                style: TextStyle(
                  color: ColorManager.gray,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
    }
  }
}