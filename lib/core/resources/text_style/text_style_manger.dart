import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyleManager {
  static TextStyle appNameStyle = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.white,
  );

  static TextStyle bodyTextStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: ColorManager.white,
  );

  // Titles
  static TextStyle pageTitleStyle = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.black,
  );

  static TextStyle sectionTitleStyle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: ColorManager.black,
  );

  // Subtitles
  static TextStyle subtitleStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: ColorManager.gray,
  );

  // Body
  static TextStyle bodyStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: ColorManager.black,
  );

  // Buttons
  static TextStyle buttonStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: ColorManager.white,
  );

  // TextField
  static TextStyle textFieldStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.black,
  );

  static TextStyle hintStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.gray,
  );

  // Caption
  static TextStyle captionStyle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.gray,
  );

  // Error
  static TextStyle errorStyle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: Colors.red,
  );
}