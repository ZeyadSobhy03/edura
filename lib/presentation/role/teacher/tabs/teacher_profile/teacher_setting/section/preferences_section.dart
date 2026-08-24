import 'package:flutter/material.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../../../../../student/tabs/profile/section/settings/sections/settings_group_card.dart';
import '../../../../../student/tabs/profile/section/settings/sections/settings_section_header.dart';
import '../../../../../student/tabs/profile/section/settings/widgets/settings_tile.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({
    super.key,
    required this.languageCode,
    this.showLanguagePicker,
  });

  final String languageCode;

  final void Function()? showLanguagePicker;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionHeader(title: l10.preferences),
        SettingsGroupCard(
          children: [
            SettingsTile(
              icon: Icons.language,
              title: l10.language,
              trailingText: languageCode == 'en' ? 'English' : 'العربية',
              onTap: showLanguagePicker,
            ),
          ],
        ),
      ],
    );
  }
}
