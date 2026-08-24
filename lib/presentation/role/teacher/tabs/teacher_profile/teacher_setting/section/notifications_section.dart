import 'package:flutter/material.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../../../../../student/tabs/profile/section/settings/sections/settings_group_card.dart';
import '../../../../../student/tabs/profile/section/settings/sections/settings_section_header.dart';
import '../../../../../student/tabs/profile/section/settings/widgets/settings_tile.dart';

class NotificationsSection extends StatelessWidget {
  const NotificationsSection({
    super.key,
    required this.pushNotifications,
    required this.emailNotifications,
    required this.studentMessageNotifications,
    this.onPushNotificationsChanged,
    this.onEmailNotificationsChanged,
    this.onStudentMessageNotificationsChanged,
  });

  final bool pushNotifications;
  final bool emailNotifications;

  final bool studentMessageNotifications;

  final void Function(bool)? onPushNotificationsChanged;
  final void Function(bool)? onEmailNotificationsChanged;
  final void Function(bool)? onStudentMessageNotificationsChanged;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionHeader(title: l10.notifications),
        SettingsGroupCard(
          children: [
            SettingsTile(
              icon: Icons.notifications_outlined,
              title: l10.pushNotifications,
              toggleValue: pushNotifications,
              onToggleChanged: onPushNotificationsChanged,
            ),
            SettingsTile(
              icon: Icons.email_outlined,
              title: l10.emailNotifications,
              toggleValue: emailNotifications,
              onToggleChanged: onEmailNotificationsChanged,
            ),
            SettingsTile(
              icon: Icons.chat_bubble_outline,
              title: l10.studentMessageAlerts,
              toggleValue: studentMessageNotifications,
              onToggleChanged: onStudentMessageNotificationsChanged,
            ),
          ],
        ),
      ],
    );
  }
}
