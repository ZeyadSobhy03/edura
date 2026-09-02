import 'package:edura/core/extensions/text_ex.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_text_formed_field.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../widgets/build_label.dart';
import '../widgets/grade_selector.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.parentPhoneController,
    required this.schoolController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.onPasswordVisibilityToggle,
    required this.onConfirmPasswordVisibilityToggle,
    required this.grades,
    required this.selectedGrade,
    required this.onGradeChanged,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController parentPhoneController;
  final TextEditingController schoolController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  final VoidCallback onPasswordVisibilityToggle;
  final VoidCallback onConfirmPasswordVisibilityToggle;
  final List<String> grades;
  final String? selectedGrade;

  final ValueChanged<String> onGradeChanged;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildLabel(label: l10.fullName),
        const SizedBox(height: 4),
        CustomTextFormedField(
          hintText: l10.enterYourFullName,
          controller: fullNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10.pleaseEnterYourFullName;
            }

            return null;
          },
        ),
        const SizedBox(height: 8),
        BuildLabel(label: l10.email),
        const SizedBox(height: 4),
        CustomTextFormedField(
          hintText: l10.enterYourEmail,
          controller: emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10.pleaseEnterYourEmail;
            }
            if (!value.isValidEmail) {
              return l10.pleaseEnterValidEmail;
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        BuildLabel(label: l10.phoneNumber),
        const SizedBox(height: 4),
        CustomTextFormedField(
          hintText: l10.enterYourPhoneNumber,
          keyboardType: TextInputType.phone,
          controller: phoneNumberController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10.pleaseEnterYourPhoneNumber;
            }
            if (!value.isValidPhoneNumber) {
              return l10.pleaseEnterValidPhoneNumber;
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        BuildLabel(label: l10.parentPhone),
        const SizedBox(height: 4),
        CustomTextFormedField(
          hintText: l10.enterYourParentPhone,
          keyboardType: TextInputType.phone,
          controller: parentPhoneController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10.pleaseEnterYourParentPhone;
            }
            if (!value.isValidPhoneNumber) {
              return l10.pleaseEnterValidPhoneNumber;
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        BuildLabel(label: l10.school),
        const SizedBox(height: 4),
        CustomTextFormedField(
          hintText: l10.enterYourSchool,
          controller: schoolController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10.pleaseEnterYourSchool;
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        BuildLabel(label: l10.password),
        const SizedBox(height: 4),
        CustomTextFormedField(
          hintText: l10.enterYourPassword,
          isObscure: !isPasswordVisible,
          controller: passwordController,
          suffix: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: ColorManager.gray,
            ),
            onPressed: onPasswordVisibilityToggle,
          ),
        ),
        const SizedBox(height: 8),
        BuildLabel(label: l10.confirmPassword),
        const SizedBox(height: 4),
        CustomTextFormedField(
          hintText: l10.enterYourConfirmPassword,
          isObscure: !isConfirmPasswordVisible,
          controller: confirmPasswordController,
          suffix: IconButton(
            icon: Icon(
              isConfirmPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: ColorManager.gray,
            ),
            onPressed: onConfirmPasswordVisibilityToggle,
          ),
        ),
        const SizedBox(height: 8),
        BuildLabel(label: l10.grade),
        const SizedBox(height: 4),
        GradeSelector(
          grades: grades,
          selectedGrade: selectedGrade,
          onChanged: onGradeChanged,
        ),
      ],
    );
  }
}
