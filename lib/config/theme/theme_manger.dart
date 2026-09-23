import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

class ThemeManger {
  static ThemeData light = ThemeData.light().copyWith(
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Color(0xFFBFD3FF),
      cursorColor: Color(0xFF2553EB),
      selectionHandleColor: Color(0xFF2553EB),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: ColorManager.primary,
      strokeWidth: 2,
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(ColorManager.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    // inputDecorationTheme: InputDecoration(
    //   contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
    //   focusedBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(12.0),
    //     borderSide: BorderSide(color: ColorManager.gray.withValues(alpha: 0.2)),
    //   ),
    //
    //   enabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(12.0),
    //     borderSide: BorderSide(color: ColorManager.gray.withValues(alpha: 0.2)),
    //   ),
    //   errorBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(12.0),
    //     borderSide: BorderSide(color: ColorManager.red),
    //   ),
    //   errorMaxLines: 2,
    //
    //   hintStyle: TextStyle(fontSize: 14.sp),
    //
    //   border: OutlineInputBorder(
    //     borderSide: BorderSide(color: ColorManager.gray.withValues(alpha: 0.2)),
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    // ),
      /*
         decoration: InputDecoration(
              labelText: l10.subject,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
       */
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(ColorManager.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationThemeData(
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: ColorManager.gray.withValues(alpha: 0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: ColorManager.gray.withValues(alpha: 0.2)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: ColorManager.red),
      ),
      errorMaxLines: 2,
      hintStyle: TextStyle(fontSize: 14),
      border: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.gray.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(12),
      ),

    )
  );
}
