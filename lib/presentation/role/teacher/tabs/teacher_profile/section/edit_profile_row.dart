import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class EditProfileRow extends StatelessWidget {
  const EditProfileRow({super.key, required this.onEditPressed});
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: onEditPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: ColorManager.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.edit_outlined, color: ColorManager.primary, size: 16),
              const SizedBox(width: 6),
              CustomText(
                text: l10.editProfile,
                style: TextStyle(
                  color: ColorManager.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}