import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class AddQuestionButton extends StatelessWidget {
  const AddQuestionButton({super.key, this.onAddQuestion});

  final void Function()? onAddQuestion;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return InkWell(
      onTap: onAddQuestion,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: ColorManager.primary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: ColorManager.primary.withValues(alpha: 0.4),
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: ColorManager.primary, size: 18),
            const SizedBox(width: 6),
            CustomText(
              text: l10.addQuestion,
              style: TextStyle(
                color: ColorManager.primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
