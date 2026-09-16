import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DonutStatCard extends StatelessWidget {
  const DonutStatCard({
    super.key,
    required this.title,
    required this.percentage, // 0-100
    required this.color,
  });

  final String title;
  final double percentage;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
          CustomText(
            text: title,
            style: TextStyle(
              color: ColorManager.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 90,
              height: 90,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      startDegreeOffset: -90,
                      sectionsSpace: 0,
                      centerSpaceRadius: 32,
                      sections: [
                        PieChartSectionData(
                          value: percentage,
                          color: color,
                          radius: 12,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: 100 - percentage,
                          color: ColorManager.gray.withValues(alpha: 0.15),
                          radius: 12,
                          showTitle: false,
                        ),
                      ],
                    ),
                  ),
                  CustomText(
                    text: '${percentage.toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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