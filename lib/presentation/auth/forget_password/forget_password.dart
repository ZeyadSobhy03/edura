import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/images/image_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/resources/text_style/text_style_manger.dart';
import 'package:edura/core/widgets/custom_elevated_button.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_button.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../register/presentation/view/widgets/build_label.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _goToLogin() {
    Navigator.pushReplacementNamed(context, RouteManger.loginRoute);
  }

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
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(24),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: ColorManager.black,
                        size: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: CustomText(
                        text: l10.forgotPasswordTitle,
                        style: TextStyle(
                          color: ColorManager.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              SizedBox(height: 32.h),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    ImageManger.iconApp,
                    height: 90.h,
                    width: 90.w,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              CustomText(
                text: l10.forgotPasswordTitle,
                style: TextStyleManager.pageTitleStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              CustomText(
                text: l10.forgotPasswordDescription,
                style: TextStyleManager.subtitleStyle,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 24.h),
              BuildLabel(label: l10.emailAddress),
              SizedBox(height: 8.h),
              CustomTextFormedField(
                controller: _emailController,
                hintText: l10.enterYourEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 16.h),
              CustomElevatedButton(
                text: l10.resetPassword,
                onPressed: _goToLogin,
              ),
              SizedBox(height: 8.h),
              Center(
                child: CustomTextButton(
                  text: l10.backToLogin,
                  onPressed: _goToLogin,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
