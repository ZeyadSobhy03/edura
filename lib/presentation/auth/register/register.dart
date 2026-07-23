import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_elevated_button.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_button.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/auth/widgets/build_label.dart';
import 'package:edura/presentation/auth/widgets/grade_selector.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? _selectedGrade;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  static const _grades = ['Grade 9', 'Grade 10', 'Grade 11', 'Grade 12'];

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios, color: ColorManager.black)),
                  Expanded(
                    child: Center(
                      child: CustomText(
                        text: l10.createAnAccount,
                        style: TextStyle(
                          color: ColorManager.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              BuildLabel(label: l10.fullName),
              const SizedBox(height: 4),
              CustomTextFormedField(hintText: l10.enterYourFullName),
              const SizedBox(height: 8),
              BuildLabel(label: l10.email),
              const SizedBox(height: 4),
              CustomTextFormedField(hintText: l10.enterYourEmail),
              const SizedBox(height: 8),
              BuildLabel(label: l10.phoneNumber),
              const SizedBox(height: 4),
              CustomTextFormedField(hintText: l10.enterYourPhoneNumber,keyboardType:TextInputType.phone ,),
              const SizedBox(height: 8),
              BuildLabel(label: l10.parentPhone),
              const SizedBox(height: 4),
              CustomTextFormedField(hintText: l10.enterYourParentPhone,keyboardType:TextInputType.phone ,),
              const SizedBox(height: 8),
              BuildLabel(label: l10.school),
              const SizedBox(height: 4),
              CustomTextFormedField(hintText: l10.enterYourSchool),
              const SizedBox(height: 8),
              BuildLabel(label: l10.password),
              const SizedBox(height: 4),
              CustomTextFormedField(
                hintText: l10.enterYourPassword,
                isObscure: !_isPasswordVisible,
                suffix: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: ColorManager.gray,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),
              BuildLabel(label: l10.confirmPassword),
              const SizedBox(height: 4),
              CustomTextFormedField(
                hintText: l10.enterYourConfirmPassword,
                isObscure: !_isConfirmPasswordVisible,
                suffix: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: ColorManager.gray,

                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),


              ),
              const SizedBox(height: 8),
              BuildLabel(label: l10.grade),
              const SizedBox(height: 4),
              GradeSelector(
                grades: _grades,
                selectedGrade: _selectedGrade,
                onChanged: (grade) => setState(() => _selectedGrade = grade),
              ),
              const SizedBox(height: 16),
              CustomElevatedButton(text: l10.createAnAccount, onPressed: () {}),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: l10.alreadyHaveAnAccount,
                    style: TextStyle(color: ColorManager.gray, fontSize: 14),
                  ),
                  CustomTextButton(
                    text: l10.login,
                    onPressed: () {
                      Navigator.pushNamed(context, RouteManger.loginRoute);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
