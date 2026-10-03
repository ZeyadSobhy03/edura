
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    this.trailingText,
    this.toggleValue,
    this.onToggleChanged,
    this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String title;
  final Color? iconColor;
  final String? trailingText;
  final bool? toggleValue; 
  final ValueChanged<bool>? onToggleChanged;
  final VoidCallback? onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? Colors.red : (iconColor ?? ColorManager.primary);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomText(
                text: title,
                style: TextStyle(
                  color: isDestructive ? Colors.red : ColorManager.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (toggleValue != null)
              Switch(
                value: toggleValue!,
                onChanged: onToggleChanged,
                activeThumbColor: ColorManager.primary,
              )
            else if (trailingText != null) ...[
              CustomText(
                text: trailingText!,
                style: TextStyle(
                  color: ColorManager.black.withValues(alpha: 0.45),
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right,
                  color: ColorManager.black.withValues(alpha: 0.3), size: 20),
            ] else if (onTap != null)
              Icon(Icons.chevron_right,
                  color: ColorManager.black.withValues(alpha: 0.3), size: 20),
          ],
        ),
      ),
    );
  }
}