import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, this.onPressed, required this.text});

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text,
        style:  TextStyle(
          color: ColorManager.primary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        )));
    }
}
