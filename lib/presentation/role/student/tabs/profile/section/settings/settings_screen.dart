import 'package:edura/core/model/edit_profile_arguments.dart';
import 'package:edura/core/model/web_view_arguments.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/settings/widgets/language_picker_sheet.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/settings/sections/profile_summary_card.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/settings/sections/settings_group_card.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/settings/sections/settings_section_header.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/settings/widgets/settings_tile.dart';
import 'package:flutter/material.dart';

import '../../../../../../../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;

  String _languageCode = 'en';

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => LanguagePickerSheet(
        currentLanguageCode: _languageCode,
        onSelected: (code) {
          setState(() => _languageCode = code);
          // TODO: call your app's locale-switching logic here
          // e.g. context.read<LocaleCubit>().setLocale(Locale(code));
        },
      ),
    );
  }

  void _confirmLogout() {
    final l10 = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10.logout),
        content: Text(l10.logoutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              // TODO: call your sign-out logic + navigate to Login
            },
            child: Text(l10.logout, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.settings,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileSummaryCard(
                name: 'Ziyad Sobhy',
                email: 'ziyad.sobhy@example.com',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteManger.editProfileScreen,
                    arguments: EditProfileArguments(
                      currentName: "Ziyad",
                      currentEmail: 'Ziyad@gmail.com',
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              SettingsSectionHeader(title: l10.preferences),
              SettingsGroupCard(
                children: [
                  SettingsTile(
                    icon: Icons.language,
                    title: l10.language,
                    trailingText: _languageCode == 'en' ? 'English' : 'العربية',
                    onTap: _showLanguagePicker,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SettingsSectionHeader(title: l10.notifications),
              SettingsGroupCard(
                children: [
                  SettingsTile(
                    icon: Icons.notifications_outlined,
                    title: l10.pushNotifications,
                    toggleValue: _pushNotifications,
                    onToggleChanged: (value) =>
                        setState(() => _pushNotifications = value),
                  ),
                  SettingsTile(
                    icon: Icons.email_outlined,
                    title: l10.emailNotifications,
                    toggleValue: _emailNotifications,
                    onToggleChanged: (value) =>
                        setState(() => _emailNotifications = value),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              SettingsSectionHeader(title: l10.account),
              SettingsGroupCard(
                children: [
                  SettingsTile(
                    icon: Icons.lock_outline,
                    title: l10.changePassword,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.changePasswordScreen,
                      );
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
                          url: 'https://yourapp.com/privacy-policy',
                          title: l10.privacyPolicy,
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
                          url: 'https://yourapp.com/terms-of-service',
                          title: l10.termsOfService,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              SettingsSectionHeader(title: l10.support),
              SettingsGroupCard(
                children: [
                  SettingsTile(
                    icon: Icons.help_outline,
                    title: l10.helpCenter,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.helpAndFaqScreen,
                      );
                    },
                  ),
                  SettingsTile(
                    icon: Icons.chat_bubble_outline,
                    title: l10.contactSupport,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.getSupportScreen,
                      );
                    },
                  ),
                  SettingsTile(
                    icon: Icons.info_outline,
                    title: l10.about,
                    trailingText: 'v1.0.0',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),

              SettingsGroupCard(
                children: [
                  SettingsTile(
                    icon: Icons.logout,
                    title: l10.logout,
                    isDestructive: true,
                    onTap: _confirmLogout,
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
