import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/model/attendance_taking_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import 'attendance_mark_style.dart';

class StudentAttendanceRow extends StatelessWidget {
  const StudentAttendanceRow({
    super.key,
    required this.student,
    required this.onStatusTap,
  });

  final StudentAttendanceModel student;
  final VoidCallback onStatusTap;

  String get _initials {
    final parts = student.name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts.isNotEmpty ? parts[0][0].toUpperCase() : '?';
  }

  Color get _avatarColor {
    final colors = [Colors.blue, Colors.purple, Colors.teal, Colors.indigo, Colors.brown];
    return colors[student.name.hashCode % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final style = AttendanceMarkStyle.of(student.status, l10);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: _avatarColor.withValues(alpha: 0.15),
            child: CustomText(
              text: _initials,
              style: TextStyle(
                color: _avatarColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: student.name,
                  style: TextStyle(
                    color: ColorManager.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                CustomText(
                  text: student.grade,
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onStatusTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: style.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: CustomText(
                text: style.label,
                style: TextStyle(
                  color: style.color,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}