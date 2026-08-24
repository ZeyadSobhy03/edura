import 'package:edura/core/model/teacher_profile_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/resources/routes/route_manger.dart';
import '../../../../../../../l10n/app_localizations.dart';
import '../../../../../student/tabs/profile/section/settings/sections/settings_group_card.dart';
import '../../../../../student/tabs/profile/section/settings/sections/settings_section_header.dart';
import '../../../../../student/tabs/profile/section/settings/widgets/settings_tile.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key, required this.teacher});

  final TeacherProfileModel teacher;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionHeader(title: l10.account),
        SettingsGroupCard(
          children: [
            SettingsTile(
              icon: Icons.person_outline,
              title: l10.editProfile,
              onTap: () async {
                Navigator.pushNamed(
                  context,
                  RouteManger.teacherProfileEditScreen,
                  arguments: teacher,
                );
              },
            ),
            SettingsTile(
              icon: Icons.lock_outline,
              title: l10.changePassword,
              onTap: () {
                Navigator.pushNamed(context, RouteManger.changePasswordScreen);
              },
            ),
            SettingsTile(
              icon: Icons.school_outlined,
              title: l10.mySubjectsAndClasses,
              onTap: () {
                Navigator.pushNamed(context, RouteManger.subjectsClassesScreen);
              },
            ),
          ],
        ),
      ],
    );
  }
}
