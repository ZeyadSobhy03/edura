import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/model/attendance_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';



class MonthlyTrendChart extends StatelessWidget {
  const MonthlyTrendChart({super.key, required this.months});

  final List<MonthlyAttendanceModel> months;

  static const double _maxBarHeight = 70;

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
            text: l10.monthlyTrend,
            style: TextStyle(
              color: ColorManager.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: months.asMap().entries.map((entry) {
              final isLast = entry.key == months.length - 1;
              final month = entry.value;

              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: (_maxBarHeight * month.attendanceRate).clamp(6, _maxBarHeight),
                      width: 22,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: isLast
                            ? ColorManager.primary
                            : ColorManager.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      text: month.monthLabel,
                      style: TextStyle(
                        color: isLast
                            ? ColorManager.primary
                            : ColorManager.black.withValues(alpha: 0.5),
                        fontSize: 11,
                        fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}