import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AnalyticsStatCard extends StatelessWidget {
  const AnalyticsStatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    required this.changeLabel,
    this.isPositive = true,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final String changeLabel;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 10),
          CustomText(
            text: value,
            style: TextStyle(
              color: ColorManager.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          CustomText(
            text: label,
            style: TextStyle(
              color: ColorManager.black.withValues(alpha: 0.55),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          CustomText(
            text: changeLabel,
            style: TextStyle(
              color: isPositive ? Colors.green : Colors.red,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}