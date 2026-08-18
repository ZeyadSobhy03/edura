import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/analytics_model.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../widgets/analytics_stat_card.dart';
import '../widgets/analytics_time_range_tabs.dart';
import '../widgets/donut_stat_card.dart';
import '../widgets/exam_performance_card.dart';
import '../widgets/monthly_bar_chart_card.dart';
import '../widgets/weekly_line_chart_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  AnalyticsRange _range = AnalyticsRange.week;

  final List<WeeklyPointModel> _weeklyGrowth = [
    WeeklyPointModel(label: 'Mon', value: 20),
    WeeklyPointModel(label: 'Tue', value: 35),
    WeeklyPointModel(label: 'Wed', value: 45),
    WeeklyPointModel(label: 'Thu', value: 60),
    WeeklyPointModel(label: 'Fri', value: 55),
    WeeklyPointModel(label: 'Sat', value: 70),
    WeeklyPointModel(label: 'Sun', value: 62),
  ];

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final List<String>localizedMonth = [
      l10.january,
      l10.february,
      l10.march,
      l10.april,
      l10.may,
      l10.june,
      l10.july,
      l10.august,
      l10.september,
      l10.october,
      l10.november,
      l10.december,

    ];
    final List<String> localizedWeekDays = [
      l10.monday,
      l10.tuesday,
      l10.wednesday,
      l10.thursday,
      l10.friday,
      l10.saturday,
      l10.sunday,
    ];

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnalyticsTimeRangeTabs(
                selected: _range,
                onSelected: (range) => setState(() => _range = range),
              ),
              const SizedBox(height: 16),

              // 2x2 stat grid
              Row(
                children: [
                  Expanded(
                    child: AnalyticsStatCard(
                      icon: Icons.people_outline,
                      iconColor: Colors.blue,
                      value: '623',
                      label: l10.totalStudents,
                      changeLabel: '+12%',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AnalyticsStatCard(
                      icon: Icons.emoji_events_outlined,
                      iconColor: Colors.green,
                      value: '74%',
                      label: l10.avgScore,
                      changeLabel: '+3%',
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
                      value: '5',
                      label: l10.lessons,
                      changeLabel: l10.active,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AnalyticsStatCard(
                      icon: Icons.attach_money,
                      iconColor: Colors.orange,
                      value: '\$14.4k',
                      label: l10.revenue,
                      changeLabel: '+8%',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              WeeklyLineChartCard(
                title: l10.studentGrowth,
                subtitle: l10.weeklyEnrollments,
                data: _weeklyGrowth,
              ),
              const SizedBox(height: 16),

              MonthlyBarChartCard(
                title: l10.monthlyRevenue,
                subtitle: l10.last4Months,
                labels: localizedMonth.sublist(0, 4),
                values: const [0.55, 0.7, 0.6, 0.9],
                barColor: Colors.green,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: DonutStatCard(
                      title: l10.lessonCompletion,
                      percentage: 78,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DonutStatCard(
                      title: l10.attendanceRate,
                      percentage: 89,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              MonthlyBarChartCard(
                title: l10.dailyAttendance,
                subtitle: '',
                labels: localizedWeekDays,
                values: const [0.8, 0.75, 0.85, 0.7, 0.9, 0.6, 0.5],
                barColor: Colors.blue,
              ),
              const SizedBox(height: 16),

              const ExamPerformanceCard(
                examTitle: 'Physics Quiz #3',
                avgScore: 81,
                passRate: 85,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}