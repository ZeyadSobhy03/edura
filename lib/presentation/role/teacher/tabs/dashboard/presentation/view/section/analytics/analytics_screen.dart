import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../core/model/analytics_model.dart';
import '../../../../../../../../../l10n/app_localizations.dart';
import '../../../../data/model/analytics/teacher_analytics_model.dart';
import '../../../view_model/analytics/analytics_view_model.dart';
import '../../widgets/analytics_stat_card.dart';
import '../../widgets/analytics_time_range_tabs.dart';
import '../../widgets/donut_stat_card.dart';
import '../../widgets/exam_performance_card.dart';
import '../../widgets/monthly_bar_chart_card.dart';
import '../../widgets/weekly_line_chart_card.dart';


class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  AnalyticsRange _range = AnalyticsRange.week;

  @override
  void initState() {
    super.initState();
    context.read<AnalyticsCubit>().load(_range.name); // 'week' | 'month' | 'year'
  }

  void _onRangeChanged(AnalyticsRange range) {
    setState(() => _range = range);
    context.read<AnalyticsCubit>().load(range.name);
  }

  List<double> _normalized(List<ChartPoint> points) {
    if (points.isEmpty) return const [];
    final max = points.map((p) => p.value).fold<double>(0, (a, b) => a > b ? a : b);
    if (max <= 0) return points.map((_) => 0.0).toList();
    return points.map((p) => p.value / max).toList();
  }

  String _money(double v) {
    if (v >= 1000) return '\$${(v / 1000).toStringAsFixed(1)}k';
    return '\$${v.toStringAsFixed(0)}';
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
          text: l10.analytics,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<AnalyticsCubit, AnalyticsState>(
          builder: (context, state) {
            if (state is AnalyticsLoading || state is AnalyticsInitial) {
              return Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            }
            if (state is AnalyticsError) {
              return Center(
                child: CustomText(
                  text: l10.errorOccurred,
                  style: TextStyle(color: ColorManager.red),
                ),
              );
            }

            final data = (state as AnalyticsLoaded).data;

            final weeklyGrowth = data.weeklyGrowth
                .map((p) => WeeklyPointModel(label: p.label, value: p.value))
                .toList();

            final monthlyLabels = data.monthlyRevenue.map((p) => p.label).toList();
            final monthlyValues = _normalized(data.monthlyRevenue);

            final dailyLabels = data.dailyAttendance.map((p) => p.label).toList();
            final dailyValues = data.dailyAttendance.map((p) => p.value / 100).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnalyticsTimeRangeTabs(
                    selected: _range,
                    onSelected: _onRangeChanged,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: AnalyticsStatCard(
                          icon: Icons.people_outline,
                          iconColor: Colors.blue,
                          value: '${data.totalStudents}',
                          label: l10.totalStudents,
                          changeLabel: '',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AnalyticsStatCard(
                          icon: Icons.emoji_events_outlined,
                          iconColor: Colors.green,
                          value: '${data.avgScore.toStringAsFixed(0)}%',
                          label: l10.avgScore,
                          changeLabel: '',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: AnalyticsStatCard(
                          icon: Icons.menu_book_outlined,
                          iconColor: Colors.purple,
                          value: '${data.activeLessons}',
                          label: l10.lessons,
                          changeLabel: l10.active,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AnalyticsStatCard(
                          icon: Icons.attach_money,
                          iconColor: Colors.orange,
                          value: _money(data.revenueTotal),
                          label: l10.revenue,
                          changeLabel: '',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  WeeklyLineChartCard(
                    title: l10.studentGrowth,
                    subtitle: l10.weeklyEnrollments,
                    data: weeklyGrowth,
                  ),
                  const SizedBox(height: 16),

                  MonthlyBarChartCard(
                    title: l10.monthlyRevenue,
                    subtitle: l10.last4Months,
                    labels: monthlyLabels,
                    values: monthlyValues,
                    barColor: Colors.green,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: DonutStatCard(
                          title: l10.lessonCompletion,
                          percentage: data.lessonCompletionPct.round(),
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DonutStatCard(
                          title: l10.attendanceRate,
                          percentage: data.attendanceRatePct.round(),
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  MonthlyBarChartCard(
                    title: l10.dailyAttendance,
                    subtitle: '',
                    labels: dailyLabels,
                    values: dailyValues,
                    barColor: Colors.blue,
                  ),
                  const SizedBox(height: 16),

                  if (data.latestExam != null)
                    ExamPerformanceCard(
                      examTitle: data.latestExam!.title,
                      avgScore: data.latestExam!.avgScore.round(),
                      passRate: data.latestExam!.passRate.round(),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}