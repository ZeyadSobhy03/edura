import 'package:edura/core/model/analytics_model.dart';
import 'package:edura/core/model/recent_activity_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_label.dart';
import 'package:edura/core/widgets/custom_text_button.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/widgets/activity_card.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/widgets/quick_action_card.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/widgets/stat_card.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/widgets/student_growth_card.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/routes/route_manger.dart';
import '../../../student/tabs/home/widgets/home_header.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final statCardData = [
      {
        'icon': Icons.person,
        'color': ColorManager.primary,
        'navigateTo': RouteManger.teacherStudentsScreen,
        'value': 550,
        'label': l10.totalOfStudents,
        'description': l10.totalNumberOfStudents(30),
      },
      {
        'icon': Icons.flash_on,
        'color': ColorManager.green,
        'navigateTo': RouteManger.teacherStudentsScreen,
        'value': 15,
        'label': l10.activeStudents,
        'description': l10.totalNumberOfActiveStudents(20),
      },
      {
        'icon': Icons.attach_money_rounded,
        'color': ColorManager.orange,
        'navigateTo': RouteManger.teacherChatsScreen,
        'value': 30,
        'label': l10.revenue,
        'description': l10.totalRevenue(30),
      },
      {
        'icon': Icons.calendar_today_outlined,
        'color': ColorManager.purple,
        'navigateTo': RouteManger.teacherProfileScreen,
        'value': 1,
        'label': l10.todaysClasses,
        'description': l10.totalNumberOfTodaysClasses(1),
      },
    ];

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                userName: "Ziyad Sobhy",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteManger.teacherNotificationScreen,
                  );
                },
              ),
              const SizedBox(height: 8),
              GridView.builder(
                itemCount: statCardData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final data = statCardData[index];
                  final icon = data['icon'] as IconData;
                  final color = data['color'] as Color;
                  final navigateTo = data['navigateTo'] as String;
                  final value = data['value'] as int;
                  final label = data['label'] as String;
                  final description = data['description'] as String;

                  return StatCard(
                    icon: icon,
                    color: color,
                    navigateTo: navigateTo,
                    value: value,
                    label: label,
                    description: description,
                  );
                },
              ),
              const SizedBox(height: 8),
              StudentGrowthCard(
                totalStudents: 30,
                weeklyData: DummyAnalyticsData.weeklyStudentGrowth,
                onViewAnalytics: () {
                  Navigator.pushNamed(context, RouteManger.analyticsScreen);
                },
              ),
              const SizedBox(height: 8),
              CustomLabel(label: l10.quickActions),
              Row(
                children: [
                  Expanded(
                    child: QuickActionCard(
                      icon: Icons.add,
                      label: l10.addLesson,
                      color: ColorManager.primary,
                      navigateTo: RouteManger.addNewLessonScreen,
                    ),
                  ),
                  Expanded(
                    child: QuickActionCard(
                      icon: Icons.border_color,
                      label: l10.createExam,
                      color: ColorManager.purple,
                      navigateTo: RouteManger.questionBuilderScreen,
                    ),
                  ),
                  Expanded(
                    child: QuickActionCard(
                      icon: Icons.qr_code,
                      label: l10.attendance,
                      color: ColorManager.green,
                      navigateTo: RouteManger.takeAttendanceScreen,
                    ),
                  ),
                  Expanded(
                    child: QuickActionCard(
                      icon: Icons.notifications_outlined,
                      label: l10.notify,
                      color: ColorManager.orange,
                      navigateTo: RouteManger.teacherNotificationScreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CustomLabel(label: l10.recentActivities),
                  const Spacer(),
                  CustomTextButton(
                    text: l10.viewAll,
                    onPressed: () {
                      Navigator.pushNamed(context, RouteManger.analyticsScreen);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ListView.builder(
                itemCount: DummyActivityModel.getDummyActivities().length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final activity =
                      DummyActivityModel.getDummyActivities()[index];

                  return ActivityCard(activity: activity);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
