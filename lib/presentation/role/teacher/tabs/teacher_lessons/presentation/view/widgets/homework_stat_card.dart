import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class HomeworkStatCard extends StatelessWidget {
  const HomeworkStatCard({super.key, required this.count, required this.label, required this.color});

  final int count;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          CustomText(
            text: '$count',
            style: TextStyle(color: color, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          CustomText(
            text: label,
            style: TextStyle(color: ColorManager.black.withValues(alpha: 0.5), fontSize: 12),
          ),
        ],
      ),
    );
  }
}