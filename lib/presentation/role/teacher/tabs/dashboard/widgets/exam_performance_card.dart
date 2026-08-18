import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';


class ExamPerformanceCard extends StatelessWidget {
  const ExamPerformanceCard({
    super.key,
    required this.examTitle,
    required this.avgScore,
    required this.passRate,
  });

  final String examTitle;
  final double avgScore;
  final double passRate;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: l10.examPerformance,
            style: TextStyle(
              color: ColorManager.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: examTitle,
                style: TextStyle(
                  color: ColorManager.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomText(
                text: '${avgScore.toStringAsFixed(0)}% ${l10.avg}',
                style: TextStyle(
                  color: ColorManager.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: avgScore / 100,
              minHeight: 6,
              backgroundColor: ColorManager.gray.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation(ColorManager.primary),
            ),
          ),
          const SizedBox(height: 6),
          CustomText(
            text: l10.passRate(passRate.toStringAsFixed(0)),
            style: TextStyle(
              color: ColorManager.black.withValues(alpha: 0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}