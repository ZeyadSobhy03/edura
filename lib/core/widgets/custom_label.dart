import 'package:flutter/material.dart';

import '../resources/colors/color_manger.dart';
import 'custom_text.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel({super.key, required this.label, this.fontSize=16, this.color = ColorManager.black});

  final String label;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: label,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
