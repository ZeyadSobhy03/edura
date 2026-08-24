import 'package:flutter/material.dart';

import '../../../../../../../core/model/web_view_arguments.dart';
import '../../../../../../../core/resources/routes/route_manger.dart';
import '../../../../../../../l10n/app_localizations.dart';
import '../../../../../student/tabs/profile/section/settings/sections/settings_group_card.dart';
import '../../../../../student/tabs/profile/section/settings/sections/settings_section_header.dart';
import '../../../../../student/tabs/profile/section/settings/widgets/settings_tile.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionHeader(title: l10.support),
        SettingsGroupCard(
          children: [
            SettingsTile(
              icon: Icons.help_outline,
              title: l10.helpCenter,
              onTap: () {
                Navigator.pushNamed(context, RouteManger.helpAndFaqScreen);
              },
            ),
            SettingsTile(
              icon: Icons.chat_bubble_outline,
              title: l10.contactSupport,
              onTap: () {
                Navigator.pushNamed(context, RouteManger.getSupportScreen);
              },
            ),
            SettingsTile(
              icon: Icons.privacy_tip_outlined,
              title: l10.privacyPolicy,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteManger.webViewScreen,
                  arguments: WebViewArguments(
                    title: l10.privacyPolicy,
                    url: 'https://edura-app.com/privacy-policy',
                  ),
                );
              },
            ),
            SettingsTile(
              icon: Icons.description_outlined,
              title: l10.termsOfService,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteManger.webViewScreen,
                  arguments: WebViewArguments(
                    title: l10.termsOfService,
                    url: 'https://edura-app.com/terms-of-service',
                  ),
                );
              },
            ),
            SettingsTile(
              icon: Icons.info_outline,
              title: l10.about,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
