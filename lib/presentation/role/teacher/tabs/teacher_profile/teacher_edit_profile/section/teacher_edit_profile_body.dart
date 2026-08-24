import 'package:flutter/material.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../core/widgets/custom_label.dart';
import '../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../core/widgets/custom_text_formed_field.dart';
import '../../../../../../../l10n/app_localizations.dart';

class TeacherEditProfileBody extends StatelessWidget {
  const TeacherEditProfileBody({
    super.key,
    required this.nameController,
    required this.subjectController,
    required this.yearsController,
  });

  final TextEditingController nameController;
  final TextEditingController subjectController;
  final TextEditingController yearsController;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(
          label: l10.fullName,
          color: ColorManager.black.withValues(alpha: 0.6),
          fontSize: 13,
        ),
        CustomTextFormedField(
          filled: true,
          textInputAction: TextInputAction.next,

          fillColor: ColorManager.gray.withValues(alpha: 0.06),
          hintText: l10.enterFullName,
          controller: nameController,
        ),
        const SizedBox(height: 16),
        CustomLabel(
          label: l10.subject,
          color: ColorManager.black.withValues(alpha: 0.6),
          fontSize: 13,
        ),
        CustomTextFormedField(
          filled: true,
          textInputAction: TextInputAction.next,
          fillColor: ColorManager.gray.withValues(alpha: 0.06),
          hintText: l10.enterSubject,
          controller: subjectController,
        ),
        const SizedBox(height: 16),
        CustomLabel(
          label: l10.yearsOfExperience,
          color: ColorManager.black.withValues(alpha: 0.6),
          fontSize: 13,
        ),
        CustomTextFormedField(
          filled: true,
          textInputAction: TextInputAction.done,
          fillColor: ColorManager.gray.withValues(alpha: 0.06),
          hintText: l10.enterYearsOfExperience,
          controller: yearsController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 28),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: ColorManager.gray.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: ColorManager.black.withValues(alpha: 0.4),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomText(
                  text: l10.studentsAndRatingAreComputed,
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}
