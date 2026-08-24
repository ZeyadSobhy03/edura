import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/teacher_profile_model.dart';
import 'edit_profile_row.dart';

class TeacherProfileHeader extends StatelessWidget {
  const TeacherProfileHeader({
    super.key,
    required this.teacher,
    required this.onEditPressed,
  });

  final TeacherProfileModel teacher;
  final VoidCallback onEditPressed;

  String get _initials {
    final parts = teacher.name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts.isNotEmpty ? parts[0][0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 110,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorManager.primary.withValues(alpha: 0.3),
                ColorManager.primaryDark,
              ],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: EditProfileRow(onEditPressed: onEditPressed),
        ),

        Positioned(
          left: 16,
          bottom: -36,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: ColorManager.white,
            child: CircleAvatar(
              radius: 36,
              backgroundColor: ColorManager.primary.withValues(alpha: 0.12),
              backgroundImage:
              teacher.avatarUrl != null ? NetworkImage(teacher.avatarUrl!) : null,
              child: teacher.avatarUrl == null
                  ? CustomText(
                text: _initials,
                style: TextStyle(
                  color: ColorManager.primary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}