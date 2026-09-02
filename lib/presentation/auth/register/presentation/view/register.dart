
import 'package:edura/core/localization/error_messages.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_elevated_button.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_button.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/auth/register/presentation/view/section/register_body.dart';
import 'package:edura/presentation/auth/register/presentation/view_model/register_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/model/register_request_model.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? _selectedGrade;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  late GlobalKey<FormState> _formKey;
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController parentPhoneController;
  late TextEditingController schoolController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    parentPhoneController.dispose();
    schoolController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey<FormState>();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    parentPhoneController = TextEditingController();
    schoolController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  static const _grades = ['Grade 9', 'Grade 10', 'Grade 11', 'Grade 12'];

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: BlocConsumer<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: ColorManager.black,
                          ),
                        ),
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
                    RegisterBody(
                      fullNameController: fullNameController,
                      emailController: emailController,
                      phoneNumberController: phoneNumberController,
                      parentPhoneController: parentPhoneController,
                      schoolController: schoolController,
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                      isPasswordVisible: _isPasswordVisible,
                      isConfirmPasswordVisible: _isConfirmPasswordVisible,
                      onPasswordVisibilityToggle: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      onConfirmPasswordVisibilityToggle: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                      grades: _grades,
                      selectedGrade: _selectedGrade,
                      onGradeChanged: (grade) =>
                          setState(() => _selectedGrade = grade),
                    ),

                    const SizedBox(height: 16),
                    CustomElevatedButton(
                      text: l10.createAnAccount,
                      onPressed: () {
                        _register();
                      },
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: l10.alreadyHaveAnAccount,
                          style: TextStyle(
                            color: ColorManager.gray,
                            fontSize: 14,
                          ),
                        ),
                        CustomTextButton(
                          text: l10.login,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteManger.loginRoute,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is RegisterLoading) {
            Fluttertoast.showToast(
              msg: l10.registering,
              backgroundColor: ColorManager.blue,
              gravity: ToastGravity.BOTTOM,
            );
          }
          if (state is RegisterSuccess) {
            Fluttertoast.showToast(
              msg: l10.registerSuccess,
              backgroundColor: ColorManager.green,
              gravity: ToastGravity.BOTTOM,
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteManger.studentMainLayoutRoute,
              (route) => false,
            );
          }
          if (state is RegisterFailure) {
            Fluttertoast.showToast(
              msg: ErrorMessages.get(context, state.error),
              backgroundColor: ColorManager.red,
              gravity: ToastGravity.BOTTOM,
            );
          }
        },
      ),
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final registerRequest = RegisterRequestModel(
        name: fullNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneNumberController.text.trim(),
        parentPhone: parentPhoneController.text.trim(),
        school: schoolController.text.trim(),
        password: passwordController.text,
        grade: _selectedGrade ?? '',
      );

      await context.read<RegisterCubit>().register(student: registerRequest);
    }
  }
}
