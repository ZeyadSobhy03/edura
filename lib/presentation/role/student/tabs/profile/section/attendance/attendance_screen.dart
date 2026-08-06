import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/model/attendance_model.dart';
import '../../../../../../../l10n/app_localizations.dart';
import 'section/attendance_record_tile.dart';
import 'section/attendance_stats_banner.dart';
import 'section/monthly_trend_chart.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  int _countByStatus(List<AttendanceRecordModel> records, AttendanceStatus status) {
    return records.where((r) => r.status == status).length;
  }

  double _overallRate(List<AttendanceRecordModel> records) {
    if (records.isEmpty) return 0;
    final present = _countByStatus(records, AttendanceStatus.present);
    final late = _countByStatus(records, AttendanceStatus.late);
    return ((present + late) / records.length) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final records = DummyAttendanceData.records;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.attendance,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AttendanceStatsBanner(
                overallRate: _overallRate(records),
                presentCount: _countByStatus(records, AttendanceStatus.present),
                absentCount: _countByStatus(records, AttendanceStatus.absent),
                lateCount: _countByStatus(records, AttendanceStatus.late),
              ),
              const SizedBox(height: 16),
              MonthlyTrendChart(months: DummyAttendanceData.monthlyTrend),
              const SizedBox(height: 16),
              ...records.map((record) => AttendanceRecordTile(record: record)),
            ],
          ),
        ),
      ),
    );
  }
}