import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ActionTail extends StatelessWidget {
  const ActionTail({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    required this.icon,
    required this.iconColor,
  });

  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.black.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              padding: EdgeInsets.zero,

              onPressed: onPressed,
              icon: Icon(
                Icons.arrow_forward_ios,
                color: ColorManager.gray,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
