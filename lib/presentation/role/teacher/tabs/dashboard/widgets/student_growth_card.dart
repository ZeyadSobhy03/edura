import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/analytics_model.dart';
import '../../../../../../l10n/app_localizations.dart';


class StudentGrowthCard extends StatelessWidget {
  const StudentGrowthCard({
    super.key,
    required this.totalStudents,
    required this.weeklyData,
    required this.onViewAnalytics,
  });

  final int totalStudents;
  final List<WeeklyPointModel> weeklyData;
  final VoidCallback onViewAnalytics;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: l10.studentGrowth,
                      style: TextStyle(
                        color: ColorManager.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomText(
                      text: l10.last7Weeks,
                      style: TextStyle(
                        color: ColorManager.black.withValues(alpha: 0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: onViewAnalytics,
                child: CustomText(
                  text: l10.viewAnalytics,
                  style: TextStyle(
                    color: ColorManager.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          CustomText(
            text: '$totalStudents',
            style: TextStyle(
              color: ColorManager.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 60,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineTouchData: const LineTouchData(enabled: false),
                minY: 0,
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      weeklyData.length,
                          (i) => FlSpot(i.toDouble(), weeklyData[i].value),
                    ),
                    isCurved: true,
                    color: ColorManager.primary,
                    barWidth: 2.5,
                    dotData: FlDotData(
                      show: true,
                      checkToShowDot: (spot, data) =>
                      spot.x == weeklyData.length - 1,
                      getDotPainter: (spot, percent, bar, index) =>
                          FlDotCirclePainter(
                            radius: 4,
                            color: ColorManager.primary,
                            strokeWidth: 0,
                          ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          ColorManager.primary.withValues(alpha: 0.25),
                          ColorManager.primary.withValues(alpha: 0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}