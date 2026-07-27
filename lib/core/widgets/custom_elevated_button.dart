import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.onPressed,
    required this.text,
    this.haveIcon = false,
    this.icon = Icons.add,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool haveIcon;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: ColorManager.white,

        backgroundColor: ColorManager.primary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorManager.primary),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: haveIcon
          ? Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
