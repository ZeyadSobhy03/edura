import 'package:edura/core/extensions/text_ex.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/localization/error_messages.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/resources/text_style/text_style_manger.dart';
import 'package:edura/core/widgets/custom_elevated_button.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_button.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/auth/forget_password/presentation/view_model/forget_password_view_model.dart'; // adjust path
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/widgets/otp_input.dart';
import '../../../register/presentation/view/widgets/build_label.dart';

enum _Step { email, code, password }

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  static const int _otpLength = 6; // must match the digits in the email

  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _Step _step = _Step.email;
  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _goToLogin() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteManger.loginRoute,
      (route) => false,
    );
  }

  void _back() {
    if (_step == _Step.email) {
      Navigator.pop(context);
    } else if (_step == _Step.code) {
      _codeController.clear();
      setState(() => _step = _Step.email);
    } else {
      _goToLogin();
    }
  }

  void _resendCode() {
    _codeController.clear();
    context.read<ForgetPasswordCubit>().sendResetCode(
      _emailController.text.trim(),
    );
  }

  void _submit() {
    final cubit = context.read<ForgetPasswordCubit>();

    // Prevent double submit (e.g. onCompleted + button tap)
    if (cubit.state is ForgetPasswordLoading) return;
    if (!_formKey.currentState!.validate()) return;

    switch (_step) {
      case _Step.email:
        cubit.sendResetCode(_emailController.text.trim());
        break;
      case _Step.code:
        cubit.verifyResetCode(
          _emailController.text.trim(),
          _codeController.text.trim(),
        );
        break;
      case _Step.password:
        cubit.updatePassword(_passwordController.text.trim());
        break;
    }
  }

  String _buttonText(AppLocalizations l10) {
    switch (_step) {
      case _Step.email:
        return l10.resetPassword;
      case _Step.code:
        return l10.verifyCode;
      case _Step.password:
        return l10.saveNewPassword;
    }
  }

  String _description(AppLocalizations l10) {
    switch (_step) {
      case _Step.email:
        return l10.forgotPasswordDescription;
      case _Step.code:
        return l10.enterCodeSentTo(_emailController.text.trim());
      case _Step.password:
        return l10.chooseNewPassword;
    }
  }

  Widget _otpField(AppLocalizations l10) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildLabel(label: l10.verificationCode),
        SizedBox(height: 12.h),
        Directionality(
          textDirection: TextDirection.ltr,
          child: OtpInput(
            controller: _codeController,
            length: _otpLength,
            autofocus: true,
            validator: (value) {
              if (value == null || value.trim().length < _otpLength) {
                return l10.enterOtpCode(_otpLength);
              }
              return null;
            },
            onCompleted: (_) => _submit(), // auto-submit (optional)
          ),
        ),
      ],
    );
  }

  Widget _field(AppLocalizations l10) {
    switch (_step) {
      case _Step.email:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildLabel(label: l10.emailAddress),
            SizedBox(height: 8.h),
            CustomTextFormedField(
              controller: _emailController,
              hintText: l10.enterYourEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null || value.isEmpty) return l10.emailRequired;
                if (!value.isValidEmail) return l10.emailInvalid;
                return null;
              },
            ),
          ],
        );
      case _Step.code:
        return _otpField(l10);
      case _Step.password:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildLabel(label: l10.password),
            SizedBox(height: 8.h),
            CustomTextFormedField(
              controller: _passwordController,
              hintText: l10.enterYourPassword,
              isObscure: !_passwordVisible,
              textInputAction: TextInputAction.done,
              suffix: GestureDetector(
                onTap: () =>
                    setState(() => _passwordVisible = !_passwordVisible),
                child: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10.passwordRequired;
                }
                if (value.length < 6) return l10.passwordTooShort;
                if (!value.isValidPassword) return l10.passwordInvalid;
                return null;
              },
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        final l10 = AppLocalizations.of(context)!;

        if (state is ResetCodeSent) {
          Fluttertoast.showToast(
            msg: l10.resetCodeSentToast,
            backgroundColor: ColorManager.green,
            gravity: ToastGravity.BOTTOM,
          );
          setState(() => _step = _Step.code);
        } else if (state is ResetCodeVerified) {
          setState(() => _step = _Step.password);
        } else if (state is PasswordUpdated) {
          Fluttertoast.showToast(
            msg: l10.passwordChangedToast,
            backgroundColor: ColorManager.green,
            gravity: ToastGravity.BOTTOM,
          );
          _goToLogin();
        } else if (state is ForgetPasswordFailure) {
          debugPrint('ForgetPasswordFailure: ${state.error}');
          Fluttertoast.showToast(
            msg: ErrorMessages.get(context, state.error),
            backgroundColor: ColorManager.red,
            gravity: ToastGravity.BOTTOM,
          );
        }
      },
      builder: (context, state) {
        final loading = state is ForgetPasswordLoading;

        return Scaffold(
          backgroundColor: ColorManager.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 16,
                right: 16,
                left: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: loading ? null : _back,
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
                    // Center(
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(20),
                    //     child: Image.asset(
                    //       ImageManger.icon,
                    //       height: 90.h,
                    //       width: 90.w,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 24.h),
                    CustomText(
                      text: l10.forgotPasswordTitle,
                      style: TextStyleManager.pageTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    CustomText(
                      text: _description(l10),
                      style: TextStyleManager.subtitleStyle,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 24.h),
                    _field(l10),
                    SizedBox(height: 16.h),
                    CustomElevatedButton(
                      text: loading ? '...' : _buttonText(l10),
                      onPressed: loading ? () {} : _submit,
                    ),
                    SizedBox(height: 8.h),
                    if (_step == _Step.code)
                      Center(
                        child: CustomTextButton(
                          text: l10.resendCode,
                          onPressed: loading ? () {} : _resendCode,
                        ),
                      ),
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
          ),
        );
      },
    );
  }
}
