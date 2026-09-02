
import 'dart:developer';

import 'package:edura/core/extensions/text_ex.dart';
import 'package:edura/core/resources/localization/error_messages.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_elevated_button.dart';
import 'package:edura/core/widgets/custom_text_button.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/core/widgets/divider_row.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/auth/login/presentation/view/login.dart';
import 'package:edura/presentation/auth/login/presentation/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../register/presentation/view/widgets/build_label.dart';
import '../../../../register/presentation/view/widgets/google_login_button.dart';

class LoginSection extends StatefulWidget {
  const LoginSection({super.key, required this.role});

  final LoginRole role;

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  bool _isPasswordVisible = false;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool get isTeacher => widget.role == LoginRole.teacher;

  bool get isStudent => widget.role == LoginRole.student;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return SafeArea(
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess || state is LoginWithGoogleSuccess) {
            if (isStudent) {
              Fluttertoast.showToast(
                msg: l10.messageLoginSuccess,
                backgroundColor: ColorManager.green,
                gravity: ToastGravity.BOTTOM,
              );
              Navigator.pushNamed(context, RouteManger.studentMainLayoutRoute);
            } else {
              Fluttertoast.showToast(
                msg: l10.messageLoginSuccess,
                backgroundColor: ColorManager.green,
                gravity: ToastGravity.BOTTOM,
              );
              Navigator.pushNamed(context, RouteManger.teacherMainLayoutRoute);
            }
          } else if (state is LoginFailure || state is LoginWithGoogleFailure) {


            log("Login Error: ${state is LoginFailure ? state.error : (state as LoginWithGoogleFailure).error}");
            Fluttertoast.showToast(
              msg: ErrorMessages.get(
                context,
                state is LoginFailure
                    ? state.error
                    : (state as LoginWithGoogleFailure).error,
              ),
              backgroundColor: ColorManager.red,
              gravity: ToastGravity.BOTTOM,
            );
          } else if (state is LoginLoading || state is LoginWithGoogleLoading) {
            Fluttertoast.showToast(
              msg: l10.messageLoginLoading,
              backgroundColor: ColorManager.blue,
              gravity: ToastGravity.BOTTOM,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildLabel(label: l10.emailAddress),
                  SizedBox(height: 8.h),
                  CustomTextFormedField(
                    hintText: l10.enterYourEmail,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10.emailRequired;
                      }
                      if (!value.isValidEmail) {
                        return l10.emailInvalid;
                      }
                      return null;
                    },
                  ),
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
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10.passwordRequired;
                      }
                      if (value.length < 6) {
                        return l10.passwordTooShort;
                      }
                      if (!value.isValidPassword) {
                        return l10.passwordInvalid;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomTextButton(
                      text: l10.forgotPassword,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RouteManger.forgetPasswordRoute,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomElevatedButton(
                    text: l10.login,
                    onPressed: () {
                      _login();
                    },
                  ),
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
        },
      ),
    );
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    var email = _emailController.text.trim();
    var password = _passwordController.text.trim();
    context.read<LoginCubit>().login(email, password);
  }

  void _loginWithGoogle() {
    context.read<LoginCubit>().loginWithGoogle();
  }

  Widget _loginWithGoogleAndCreateAccountSection(
    AppLocalizations l10,
    BuildContext context,
  ) {
    return Column(
      children: [
        DividerRow(),
        SizedBox(height: 8.h),
        GoogleLoginButton(
          onPressed: () {
            _loginWithGoogle();
          },
        ),
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
