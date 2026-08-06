import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomListTail extends StatelessWidget {
  const CustomListTail({
    super.key,
    this.onTap,
    required this.text,
    required this.subTitle,
    required this.icon,
    required this.iconColor,
  });

  final void Function()? onTap;
  final String text;
  final String subTitle;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // shape: RoundedRectangleBorder(
      //   side: BorderSide(
      //     color: ColorManager.black.withValues(alpha: 0.1),
      //     width: 1,
      //   ),
      //   borderRadius: BorderRadius.circular(12),
      // ),
      onTap: onTap,
      title: CustomText(
        text: text,
        style: TextStyle(
          color: ColorManager.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: CustomText(
        text: subTitle,
        style: TextStyle(
          color: ColorManager.salatGray,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 28),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: ColorManager.salatGray,
        size: 16,
      ),
    );
  }
}
