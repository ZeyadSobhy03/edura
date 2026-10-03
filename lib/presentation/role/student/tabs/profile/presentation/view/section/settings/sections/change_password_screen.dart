import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../../teacher/tabs/teacher_profile/presentation/view_model/change_password/change_password_view_model.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    context.read<ChangePasswordCubit>().changePassword(
      oldPassword: _currentPasswordController.text,
      newPassword: _newPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          Fluttertoast.showToast(
            msg: l10.passwordChangedSuccessfully,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: ColorManager.primary,
            textColor: ColorManager.white,
          );
          Navigator.pop(context);
        }
        if (state is ChangePasswordError) {
          Fluttertoast.showToast(
            msg: state.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: ColorManager.red,
            textColor: ColorManager.white,
          );
        }
      },
      builder: (context, state) {
        final isSaving = state is ChangePasswordLoading;

        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0,
            centerTitle: true,
            title: CustomText(
              text: l10.changePassword,
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormedField(
                      controller: _currentPasswordController,
                      isObscure: _obscureCurrent,
                      hintText: l10.currentPassword,
                      suffix: IconButton(
                        icon: Icon(
                          _obscureCurrent
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () =>
                            setState(() => _obscureCurrent = !_obscureCurrent),
                      ),
                      validator: (value) => (value == null || value.isEmpty)
                          ? l10.fieldRequired
                          : null,
                    ),
                    const SizedBox(height: 16),

                    CustomTextFormedField(
                      hintText: l10.newPassword,
                      controller: _newPasswordController,
                      isObscure: _obscureNew,
                      suffix: IconButton(
                        icon: Icon(
                          _obscureNew
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () =>
                            setState(() => _obscureNew = !_obscureNew),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10.fieldRequired;
                        }
                        if (value.length < 8) return l10.passwordTooShort;
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    CustomTextFormedField(
                      controller: _confirmPasswordController,
                      isObscure: _obscureConfirm,
                      hintText: l10.confirmNewPassword,
                      suffix: IconButton(
                        icon: Icon(
                          _obscureConfirm
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () =>
                            setState(() => _obscureConfirm = !_obscureConfirm),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10.fieldRequired;
                        }
                        if (value != _newPasswordController.text) {
                          return l10.passwordsDoNotMatch;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isSaving ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isSaving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                l10.updatePassword,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
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
