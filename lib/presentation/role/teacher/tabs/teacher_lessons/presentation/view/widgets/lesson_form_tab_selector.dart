import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';


enum LessonFormStep { details, video, pdf }

class LessonFormTabSelector extends StatelessWidget {
  const LessonFormTabSelector({
    super.key,
    required this.currentStep,
    required this.onStepTapped,
    required this.videoDone,
    required this.pdfDone,
  });

  final LessonFormStep currentStep;
  final ValueChanged<LessonFormStep> onStepTapped;
  final bool videoDone;
  final bool pdfDone;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Row(
      children: [
        _tab(
          LessonFormStep.details,
          _getLabel(LessonFormStep.details, l10),
          true,
        ),
        const SizedBox(width: 8),
        _tab(
          LessonFormStep.video,
          _getLabel(LessonFormStep.video, l10),
          videoDone,
        ),
        const SizedBox(width: 8),
        _tab(LessonFormStep.pdf, _getLabel(LessonFormStep.pdf, l10), pdfDone),
      ],
    );
  }

  Widget _tab(LessonFormStep step, String label, bool isUnlocked) {
    final isSelected = step == currentStep;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (isUnlocked) {
            onStepTapped(step);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? ColorManager.primary
                : ColorManager.gray.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomText(
            text: label,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : isUnlocked
                  ? ColorManager.black.withValues(alpha: 0.6)
                  : ColorManager.black.withValues(alpha: 0.3),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  String _getLabel(LessonFormStep step, AppLocalizations l10) {
    switch (step) {
      case LessonFormStep.details:
        return l10.details;
      case LessonFormStep.video:
        return l10.video;
      case LessonFormStep.pdf:
        return l10.pdfs;
    }
  }
}
