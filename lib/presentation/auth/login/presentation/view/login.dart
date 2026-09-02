import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/images/image_manger.dart';
import 'package:edura/core/widgets/custom_tab.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/auth/login/presentation/view/section/login_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/text_style/text_style_manger.dart';

enum LoginRole { student, teacher }

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginRole _selectedRole = LoginRole.student;

  void _selectRole(LoginRole role) {
    if (_selectedRole == role) return;
    setState(() => _selectedRole = role);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  ImageManger.iconApp,
                  height: 80.h,
                  width: 80.w,
                ),
              ),
              CustomText(
                text: l10.welcomeBack,
                style: TextStyleManager.pageTitleStyle,
              ),
              SizedBox(height: 4.h),
              CustomText(
                text: l10.sinInToContinue,
                style: TextStyleManager.subtitleStyle,
              ),
              SizedBox(height: 16.h),
              _RoleSelector(
                selectedRole: _selectedRole,
                onChanged: _selectRole,
                studentLabel: l10.student,
                teacherLabel: l10.teacher,
              ),
              SizedBox(height: 16.h),
              _selectedRole == LoginRole.student
                  ? const LoginSection(role: LoginRole.student)
                  : const LoginSection(role: LoginRole.teacher),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleSelector extends StatelessWidget {
  const _RoleSelector({
    required this.selectedRole,
    required this.onChanged,
    required this.studentLabel,
    required this.teacherLabel,
  });

  final LoginRole selectedRole;
  final ValueChanged<LoginRole> onChanged;
  final String studentLabel;
  final String teacherLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: ColorManager.gray.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomTab(
              text: studentLabel,
              isSelected: selectedRole == LoginRole.student,
              selectedColor: ColorManager.white,
              unselectedColor: Colors.transparent,
              selectedTextColor: ColorManager.primary,
              unselectedTextColor: ColorManager.black,
              onTap: () => onChanged(LoginRole.student),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: CustomTab(
              text: teacherLabel,
              isSelected: selectedRole == LoginRole.teacher,
              selectedColor: ColorManager.white,
              unselectedColor: Colors.transparent,
              selectedTextColor: ColorManager.primary,
              unselectedTextColor: ColorManager.black,
              onTap: () => onChanged(LoginRole.teacher),
            ),
          ),
        ],
      ),
    );
  }
}
