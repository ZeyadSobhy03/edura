import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../students/data/model/student_attendance_history.dart';

class StudentAttendanceTile extends StatelessWidget {
  const StudentAttendanceTile({super.key, required this.student});
  final StudentAttendanceHistory student;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final presentCount = student.records
        .where((r) => r.status == 'present')
        .length;
    final totalCount = student.records.length;

    return Container(
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        title: CustomText(
          text: student.studentName,
          style: TextStyle(
            color: ColorManager.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: CustomText(
          text: '$presentCount/$totalCount ${l10.present}',
          style: TextStyle(
            color: ColorManager.black.withValues(alpha: 0.5),
            fontSize: 12,
          ),
        ),
        children: student.records.isEmpty
            ? [
          Padding(
            padding: const EdgeInsets.only(bottom: 12, left: 16),
            child: CustomText(
              text: l10.noAttendanceRecords,
              style: TextStyle(
                color: ColorManager.black.withValues(alpha: 0.4),
                fontSize: 13,
              ),
            ),
          ),
        ]
            : student.records.map((record) {
          final isPresent = record.status == 'present';
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    text: DateFormat('MMM d, yyyy').format(record.date),
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 13,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isPresent
                        ? Colors.green.withValues(alpha: 0.15)
                        : Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomText(
                    text: isPresent ? l10.present : l10.absent,
                    style: TextStyle(
                      color: isPresent ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
