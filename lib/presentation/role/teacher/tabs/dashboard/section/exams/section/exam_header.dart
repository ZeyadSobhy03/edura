import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/widgets/custom_label.dart';
import '../../../../../../../../core/widgets/custom_text_formed_field.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class ExamHeader extends StatelessWidget {
  const ExamHeader({
    super.key,
    required this.titleController,
    required this.subjectController,
    required this.durationController,
  });

  final TextEditingController titleController;
  final TextEditingController subjectController;
  final TextEditingController durationController;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(
          label: l10.examTitle,
          color: ColorManager.primary,
          fontSize: 15,
        ),
        const SizedBox(height: 6),
        CustomTextFormedField(
          hintText: l10.enterExamTitle,
          controller: titleController,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return l10.examTitleCannotBeEmpty;
            }
            return null;
          },
        ),
        const SizedBox(height: 6),
        CustomLabel(
          label: l10.examSubject,
          color: ColorManager.primary,
          fontSize: 15,
        ),
        const SizedBox(height: 6),
        CustomTextFormedField(
          hintText: l10.enterExamSubject,
          controller: subjectController,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return l10.examSubjectCannotBeEmpty;
            }
            return null;
          },
        ),
        const SizedBox(height: 6),
        CustomLabel(
          label: l10.examDuration,
          color: ColorManager.primary,
          fontSize: 15,
        ),
        const SizedBox(height: 6),
        CustomTextFormedField(
          hintText: l10.enterExamDuration,
          controller: durationController,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return l10.examDurationCannotBeEmpty;
            }
            if (int.tryParse(value) == null) {
              return l10.examDurationMustBeANumber;
            }
            return null;
          },
        ),
      ],
    );
  }
}
