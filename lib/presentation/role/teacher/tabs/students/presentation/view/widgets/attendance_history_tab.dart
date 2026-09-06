import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/model/student_detail_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';




class AttendanceHistoryTab extends StatelessWidget {
  const AttendanceHistoryTab({super.key, required this.records});

  final List<StudentAttendanceRecord> records;

  Color _statusColor(StudentAttendanceStatus status) {
    switch (status) {
      case StudentAttendanceStatus.present:
        return Colors.green;
      case StudentAttendanceStatus.absent:
        return Colors.red;
      case StudentAttendanceStatus.late:
        return Colors.orange;
    }
  }

  IconData _statusIcon(StudentAttendanceStatus status) {
    switch (status) {
      case StudentAttendanceStatus.present:
        return Icons.check_circle;
      case StudentAttendanceStatus.absent:
        return Icons.cancel;
      case StudentAttendanceStatus.late:
        return Icons.access_time_filled;
    }
  }

  String _statusLabel(StudentAttendanceStatus status, AppLocalizations l10) {
    switch (status) {
      case StudentAttendanceStatus.present:
        return l10.present;
      case StudentAttendanceStatus.absent:
        return l10.absent;
      case StudentAttendanceStatus.late:
        return l10.late;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final presentCount = records.where((r) => r.status == StudentAttendanceStatus.present).length;
    final absentCount = records.where((r) => r.status == StudentAttendanceStatus.absent).length;
    final lateCount = records.where((r) => r.status == StudentAttendanceStatus.late).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: l10.thisMonth,
                style: TextStyle(color: ColorManager.black, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: _statCol(presentCount, l10.present, Colors.green)),
                  Expanded(child: _statCol(absentCount, l10.absent, Colors.red)),
                  Expanded(child: _statCol(lateCount, l10.late, Colors.orange)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        ...records.map((record) {
          final color = _statusColor(record.status);
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
                Icon(_statusIcon(record.status), color: color, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomText(
                    text: DateFormat('MMM d').format(record.date),
                    style: TextStyle(color: ColorManager.black, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomText(
                    text: _statusLabel(record.status, l10),
                    style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _statCol(int count, String label, Color color) {
    return Column(
      children: [
        CustomText(
          text: '$count',
          style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        CustomText(
          text: label,
          style: TextStyle(color: Colors.black.withValues(alpha: 0.5), fontSize: 12),
        ),
      ],
    );
  }
}