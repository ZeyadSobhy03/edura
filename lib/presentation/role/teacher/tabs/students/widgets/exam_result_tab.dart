import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/student_detail_model.dart';
import '../../../../../../l10n/app_localizations.dart';



class ExamResultTab extends StatelessWidget {
  const ExamResultTab({super.key, required this.examResults});

  final List<ExamResult> examResults;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    if (examResults.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: CustomText(
            text: l10.noExamsFound,
            style: TextStyle(color: ColorManager.black.withValues(alpha: 0.5)),
          ),
        ),
      );
    }

    return Column(
      children: examResults.map((exam) {
        final passed = exam.score >= 60;

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                      text: exam.title,
                      style: TextStyle(color: ColorManager.black, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (passed ? Colors.green : Colors.red).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomText(
                      text: '${exam.score}/100',
                      style: TextStyle(
                        color: passed ? Colors.green : Colors.red,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: exam.score / 100,
                  minHeight: 6,
                  backgroundColor: ColorManager.gray.withValues(alpha: 0.12),
                  valueColor: AlwaysStoppedAnimation(passed ? Colors.green : Colors.red),
                ),
              ),
              const SizedBox(height: 8),
              CustomText(
                text: l10.examAvgAndPassRate(
                  exam.avgPercent.toStringAsFixed(0),
                  exam.passRatePercent.toStringAsFixed(0),
                ),
                style: TextStyle(color: ColorManager.black.withValues(alpha: 0.5), fontSize: 12),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}