import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SettingsSectionHeader extends StatelessWidget {
  const SettingsSectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8, top: 8),
      child: CustomText(
        text: title,
        style: TextStyle(
          color: ColorManager.black.withValues(alpha: 0.5),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}