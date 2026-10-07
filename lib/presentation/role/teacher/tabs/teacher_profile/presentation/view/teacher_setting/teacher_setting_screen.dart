import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/change_language_card.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/section/account_section.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/section/support_section.dart';
import 'package:flutter/material.dart';

import '../../../data/model/teacher_profile_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class TeacherSettingScreen extends StatefulWidget {
  const TeacherSettingScreen({super.key, required this.teacher});

  final TeacherProfileModel teacher;

  @override
  State<TeacherSettingScreen> createState() => _TeacherSettingScreenState();
}

class _TeacherSettingScreenState extends State<TeacherSettingScreen> {
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

              ChangeLanguageCard(),
              const SizedBox(height: 20),

              const SizedBox(height: 20),

              SupportSection(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
