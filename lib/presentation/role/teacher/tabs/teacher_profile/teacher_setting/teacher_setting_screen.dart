import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/teacher_setting/section/account_section.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/teacher_setting/section/notifications_section.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/teacher_setting/section/preferences_section.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/teacher_setting/section/support_section.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/teacher_profile_model.dart';
import '../../../../../../l10n/app_localizations.dart';

import '../../../../student/tabs/profile/section/settings/sections/settings_group_card.dart';
import '../../../../student/tabs/profile/section/settings/widgets/language_picker_sheet.dart';
import '../../../../student/tabs/profile/section/settings/widgets/settings_tile.dart';

class TeacherSettingScreen extends StatefulWidget {
  const TeacherSettingScreen({super.key, required this.teacher});

  final TeacherProfileModel teacher;

  @override
  State<TeacherSettingScreen> createState() => _TeacherSettingScreenState();
}

class _TeacherSettingScreenState extends State<TeacherSettingScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _studentMessageNotifications = true;
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
              Navigator.pop(context);
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
              AccountSection(teacher: widget.teacher),
              const SizedBox(height: 20),

              PreferencesSection(
                languageCode: _languageCode,
                showLanguagePicker: _showLanguagePicker,
              ),
              const SizedBox(height: 20),

              NotificationsSection(
                pushNotifications: _pushNotifications,
                emailNotifications: _emailNotifications,
                studentMessageNotifications: _studentMessageNotifications,

                onEmailNotificationsChanged: (value) {
                  setState(() => _emailNotifications = value);
                },
                onPushNotificationsChanged: (value) {
                  setState(() => _pushNotifications = value);
                },
                onStudentMessageNotificationsChanged: (value) {
                  setState(() => _studentMessageNotifications = value);
                },
              ),
              const SizedBox(height: 20),

              SupportSection(),
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
