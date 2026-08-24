import 'package:edura/core/model/teacher_profile_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/section/action_tail.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/section/divider_row.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({super.key, required this.teacher});
  final TeacherProfileModel teacher;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Card(
      color: ColorManager.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorManager.black.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ActionTail(
              title: l10.analytics,
              subtitle: l10.viewAnalytics,
              onPressed: () {
                Navigator.pushNamed(context, RouteManger.analyticsScreen);
              },
              icon: Icons.insert_chart_outlined,
              iconColor: ColorManager.primary,
            ),
            DividerRow(),
            ActionTail(
              title: l10.settings,
              subtitle: l10.accountPreferences,
              onPressed: () {
                Navigator.pushNamed(context, RouteManger.teacherSettingsScreen,arguments: teacher);
              },
              icon: Icons.settings_outlined,
              iconColor: ColorManager.salatGray,
            ),
            DividerRow(),
            ActionTail(
              title: l10.helpAndSupport,
              subtitle: l10.contactSupport,
              onPressed: () {},
              icon: Icons.support_agent_outlined,
              iconColor: ColorManager.green,
            ),
          ],
        ),
      ),
    );
  }
}
