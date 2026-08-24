import 'package:edura/core/model/teacher_profile_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/section/teacher_stat_pill.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class TeacherInfoRow extends StatelessWidget {
  const TeacherInfoRow({super.key, required this.teacher});

  final TeacherProfileModel teacher;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Row(
      children: [
        TeacherStatPill(
          icon: Icons.person_outline,
          value: '${teacher.studentsCount}',
          label: l10.students,
        ),
        const SizedBox(width: 20),
        TeacherStatPill(
          icon: Icons.star_outline,
          value: teacher.rating.toStringAsFixed(1),
          label: l10.rating,
        ),
        const SizedBox(width: 20),
        TeacherStatPill(
          icon: Icons.workspace_premium_outlined,
          value: '${teacher.yearsExperience}',
          label: l10.years,
        ),
      ],
    );
  }
}
