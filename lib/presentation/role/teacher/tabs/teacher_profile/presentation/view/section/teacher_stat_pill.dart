import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TeacherStatPill extends StatelessWidget {
  const TeacherStatPill({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: ColorManager.primary, size: 18),
        const SizedBox(width: 4),
        CustomText(
          text: value,
          style: TextStyle(
            color: ColorManager.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 4),
        CustomText(
          text: label,
          style: TextStyle(
            color: ColorManager.black.withValues(alpha: 0.6),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}