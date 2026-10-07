import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../../l10n/app_localizations.dart';
import '../../../view_model/attendance/attendance_view_model.dart';
import 'section/attendance_record_tile.dart';
import 'section/attendance_stats_banner.dart';
import 'section/monthly_trend_chart.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String? _studentId;

  @override
  void initState() {
    super.initState();
    _studentId = Supabase.instance.client.auth.currentUser?.id;
    _load();
  }

  Future<void> _load() async {
    final id = _studentId;
    if (id == null) return;
    await context.read<AttendanceCubit>().getStudentAttendance(id);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

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
        child: BlocBuilder<AttendanceCubit, AttendanceState>(
          builder: (context, state) {
            if (state is AttendanceLoading || state is AttendanceInitial) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            }
            if (state is AttendanceError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message, textAlign: TextAlign.center),
                    TextButton(
                      onPressed: _load,
                      child:  Text(l10.retry),
                    ),
                  ],
                ),
              );
            }
            if (state is! AttendanceLoaded) return const SizedBox.shrink();

            return RefreshIndicator(
              onRefresh: _load,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AttendanceStatsBanner(
                      overallRate: state.overallRate,
                      presentCount: state.presentCount,
                      absentCount: state.absentCount,
                      lateCount: state.lateCount,
                    ),
                    const SizedBox(height: 16),
                    if (state.records.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: Text(
                            l10.noAttendanceRecords,
                            style: TextStyle(
                              color: ColorManager.black.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      )
                    else ...[
                      MonthlyTrendChart(months: state.monthlyTrend),
                      const SizedBox(height: 16),
                      ...state.records
                          .map((r) => AttendanceRecordTile(record: r)),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}