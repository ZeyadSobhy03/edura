import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';


class StudentMultiSelectField extends StatelessWidget {
  const StudentMultiSelectField({
    super.key,
    required this.selectedNames,
    required this.onTap,
  });

  final List<String> selectedNames;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: ColorManager.gray.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.person_add_alt_1, size: 18, color: ColorManager.primary),
            const SizedBox(width: 10),
            Expanded(
              child: CustomText(
                text: selectedNames.isEmpty
                    ? l10.selectStudents
                    : selectedNames.join(', '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selectedNames.isEmpty
                      ? ColorManager.black.withValues(alpha: 0.4)
                      : ColorManager.black,
                  fontSize: 13,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: ColorManager.black.withValues(alpha: 0.3)),
          ],
        ),
      ),
    );
  }
}