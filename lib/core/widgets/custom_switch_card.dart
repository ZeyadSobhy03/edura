import 'package:flutter/material.dart';

import '../resources/colors/color_manger.dart';
import 'custom_text.dart';

class CustomSwitchCard extends StatelessWidget {
  const CustomSwitchCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    this.onChanged,
  });

  final String title;
  final bool value;

  final String subtitle;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Expanded(
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
                CustomText(
                  text: subtitle,
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: ColorManager.primary,
          ),
        ],
      ),
    );
  }
}
