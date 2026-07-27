import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_elevated_button.dart';
import 'package:edura/core/widgets/custom_text_button.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/core/widgets/divider_row.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/auth/login/login.dart';
import 'package:edura/presentation/auth/widgets/google_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/colors/color_manger.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../widgets/build_label.dart';

class LoginSection extends StatefulWidget {
  const LoginSection({super.key, required this.role});

  final LoginRole role;

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  bool _isPasswordVisible = false;

  bool get isTeacher => widget.role == LoginRole.teacher;

  bool get isStudent => widget.role == LoginRole.student;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildLabel(label: l10.emailAddress),
            SizedBox(height: 8.h),
            CustomTextFormedField(hintText: l10.enterYourEmail),
            SizedBox(height: 8.h),
            BuildLabel(label: l10.password),
            SizedBox(height: 8.h),
            CustomTextFormedField(
              textInputAction: TextInputAction.done,
              hintText: l10.enterYourPassword,
              isObscure: !_isPasswordVisible,
              suffix: GestureDetector(
                onTap: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                child: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerRight,
              child: CustomTextButton(
                text: l10.forgotPassword,
                onPressed: () {
                  Navigator.pushNamed(context, RouteManger.forgetPasswordRoute);
                },
              ),
            ),
            SizedBox(height: 8.h),
            CustomElevatedButton(text: l10.login, onPressed: () {
              Navigator.pushNamed(context, RouteManger.studentMainLayoutRoute);
            }),
            SizedBox(height: 8.h),
            isStudent
                ? _loginWithGoogleAndCreateAccountSection(l10, context)
                : Row(
                    children: [
                      CustomText(
                        text: l10.teacherAccountIssues,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorManager.gray,
                        ),
                      ),
                      CustomTextButton(
                        text: l10.contactAdmin,
                        onPressed: () {},
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _loginWithGoogleAndCreateAccountSection(
    AppLocalizations l10,
    BuildContext context,
  ) {
    return Column(
      children: [
        DividerRow(),
        SizedBox(height: 8.h),
        GoogleLoginButton(onPressed: () {}),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: l10.dontHaveAnAccount,
              style: TextStyle(fontSize: 14.sp, color: ColorManager.gray),
            ),
            CustomTextButton(
              text: l10.register,
              onPressed: () {
                Navigator.pushNamed(context, RouteManger.registerRoute);
              },
            ),
          ],
        ),
      ],
    );
  }
}
