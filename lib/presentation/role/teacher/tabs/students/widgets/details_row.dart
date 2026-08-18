import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';

class DetailsRow extends StatelessWidget {
  const DetailsRow({
    super.key,
     this.icon,
    required this.text,
    this.haveIcon = true,
  });

  final IconData? icon;
  final String text;
  final bool haveIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        haveIcon
            ? Icon(icon, color: ColorManager.gold,size: 16,)
            : CustomText(
                text: "att :",
                style: TextStyle(color: ColorManager.salatGray, fontSize: 12),
              ),
        SizedBox(width: 2),
        CustomText(
          text: text,
          style: TextStyle(color: ColorManager.salatGray, fontSize: 12),
        ),
      ],
    );
  }
}
