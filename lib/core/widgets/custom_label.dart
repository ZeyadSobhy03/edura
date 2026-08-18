import 'package:flutter/material.dart';

import '../resources/colors/color_manger.dart';
import 'custom_text.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel({super.key, required this.label, this.fontSize=16});

  final String label;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: label,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: ColorManager.black,
      ),
    );
  }
}
