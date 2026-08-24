import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';

class TeacherDetail extends StatelessWidget {
  const TeacherDetail({
    super.key,
    required this.teacherName,
    required this.teacherSubject,
  });

  final String teacherName;
  final String teacherSubject;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: teacherName,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        CustomText(
          text: teacherSubject,
          style: TextStyle(
            color: ColorManager.black.withValues(alpha: 0.6),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
