import 'package:flutter/material.dart';

import '../../../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../../../core/widgets/custom_label.dart';
import '../../../../../../../../../../core/widgets/custom_text_formed_field.dart';
import '../../../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../teacher_lessons/presentation/view/widgets/lesson_grade_selector.dart';
import '../../../../../../teacher_lessons/presentation/view/widgets/subject_selector.dart';
import '../../../../../../teacher_profile/presentation/view/teacher_grades/data/model/grade_model.dart';

class ExamHeader extends StatelessWidget {
  const ExamHeader({
    super.key,
    required this.titleController,
    required this.durationController,
    this.selectedSubject,
    required this.onSubjectChanged,
    this.selectedGradeId,
    required this.onGradeChanged,
  });

  final TextEditingController titleController;
  final TextEditingController durationController;
  final String? selectedSubject;
  final ValueChanged<String> onSubjectChanged;
  final String? selectedGradeId;
  final ValueChanged<Grade> onGradeChanged;

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
        SubjectSelector(
          selectedSubject: selectedSubject,
          onChanged: onSubjectChanged,
        ),
        const SizedBox(height: 6),

        CustomLabel(
          label: l10.examGrade,
          color: ColorManager.primary,
          fontSize: 15,
        ),
        const SizedBox(height: 6),

        LessonGradeSelector(
          forTeacher: true,
          selectedGradeId: selectedGradeId,
          onChanged: onGradeChanged,
        ),
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
