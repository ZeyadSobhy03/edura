import 'package:flutter/material.dart';

import '../resources/colors/color_manger.dart';
import 'custom_text.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: label,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: ColorManager.black,
      ),
    );
  }
}
