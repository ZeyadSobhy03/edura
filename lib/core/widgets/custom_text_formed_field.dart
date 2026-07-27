import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/colors/color_manger.dart';

class CustomTextFormedField extends StatelessWidget {
  const CustomTextFormedField({
    super.key,
    required this.hintText,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.isObscure = false,
    this.suffix,
    this.onChanged,
    this.prefix,
  });

  final String hintText;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isObscure;
  final Widget? prefix;

  final Widget? suffix;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      onChanged: onChanged,
      style: TextStyle(fontSize: 14.sp, color: ColorManager.black),
      maxLines: maxLines,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      obscureText: isObscure,

      decoration: InputDecoration(
        suffixIcon: suffix,
        prefixIcon: prefix,


        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: ColorManager.gray.withValues(alpha: 0.2),
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: ColorManager.gray.withValues(alpha: 0.2),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: ColorManager.red),
        ),
        fillColor: ColorManager.white,
        errorMaxLines: 2,

        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.sp),

        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.gray.withValues(alpha: 0.2),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
