import 'package:edura/presentation/role/teacher/tabs/teacher_profile/section/teacher_stat_card.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../l10n/app_localizations.dart';

class TeacherStatRow extends StatelessWidget {
  const TeacherStatRow({
    super.key,
    required this.lessonsCount,
    required this.examsCount,
    required this.homeworkCount,
  });

  final String lessonsCount;
  final String examsCount;
  final String homeworkCount;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: TeacherStatCard(
            label: l10.lessons,
            value: lessonsCount,
            valueColor: ColorManager.primary,
          ),
        ),
        Expanded(
          child: TeacherStatCard(
            label: l10.exams,
            value: examsCount,
            valueColor: ColorManager.purple,
          ),
        ),
        Expanded(
          child: TeacherStatCard(
            label: l10.homework,
            value: homeworkCount,
            valueColor: ColorManager.orange,
          ),
        ),
      ],
    );
  }
}
