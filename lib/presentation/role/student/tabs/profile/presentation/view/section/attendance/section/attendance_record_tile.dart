import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../data/model/attendance/attendance_model.dart';
import '../../../../../../../../../../l10n/app_localizations.dart';
import 'attendance_status_style.dart';

class AttendanceRecordTile extends StatelessWidget {
  const AttendanceRecordTile({super.key, required this.record});

  final AttendanceRecordModel record;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final style = AttendanceStatusStyle.of(record.status, l10);
    final details = [record.subject, record.teacherName]
        .where((s) => s.isNotEmpty)
        .join(' · ');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: style.color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(style.icon, color: style.color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: DateFormat('MMM d').format(record.date),
                  style: TextStyle(
                    color: ColorManager.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (details.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  CustomText(
                    text: details,
                    style: TextStyle(
                      color: ColorManager.black.withValues(alpha: 0.55),
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: style.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: CustomText(
              text: style.label,
              style: TextStyle(
                color: style.color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}