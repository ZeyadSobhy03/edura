import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';

class BuildLabel extends StatelessWidget {
  const BuildLabel({super.key, required this.label});
  final String label;


  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: label,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: ColorManager.gray,
      ),
    );
  }
}
