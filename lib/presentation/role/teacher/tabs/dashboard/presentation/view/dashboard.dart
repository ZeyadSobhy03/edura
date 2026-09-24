import 'package:edura/core/model/analytics_model.dart';
import 'package:edura/core/model/recent_activity_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_label.dart';
import 'package:edura/core/widgets/custom_text_button.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view/widgets/activity_card.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view/widgets/quick_action_card.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view/widgets/stat_card.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view/widgets/student_growth_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/resources/routes/route_manger.dart';
import '../../../../../student/tabs/home/widgets/home_header.dart';
import '../../../teacher_profile/presentation/view_model/teacher_profile_view_model.dart';
import '../view_model/dashboard/dashboard_view_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? teacherId;

  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().load();
    final currentUser = Supabase.instance.client.auth.currentUser;

    if (currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, RouteManger.loginRoute);
      });
      return;
    }

    teacherId = currentUser.id;
    context.read<TeacherProfileCubit>().getTeacherProfile(teacherId!);

  }


  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<TeacherProfileCubit, TeacherProfileState>(
                builder: (context, state) {
                  final name = state is TeacherProfileLoaded ? state.profile.name : null;

                  return HomeHeader(
                    userName: (name == null || name.isEmpty) ? l10.teacher : name,
                    onTap: () {
                      Navigator.pushNamed(context, RouteManger.teacherNotificationScreen);
                    },
                  );
                },
              ),              const SizedBox(height: 8),
              BlocBuilder<DashboardCubit, DashboardState>(
                builder: (context, state) {
                  final stats = state is DashboardLoaded ? state.stats : null;

                  final statCardData = [
                    {
                      'icon': Icons.person,
                      'color': ColorManager.primary,
                      'navigateTo': RouteManger.teacherStudentsScreen,
                      'value': stats?.totalStudents ?? 0,
                      'label': l10.totalOfStudents,
                      'description': l10.totalNumberOfStudents(
                        stats?.totalStudents ?? 0,
                      ),
                    },
                    {
                      'icon': Icons.flash_on,
                      'color': ColorManager.green,
                      'navigateTo': RouteManger.teacherStudentsScreen,
                      'value': stats?.activeStudents ?? 0,
                      'label': l10.activeStudents,
                      'description': l10.totalNumberOfActiveStudents(
                        stats?.activeStudents ?? 0,
                      ),
                    },
                    {
                      'icon': Icons.attach_money_rounded,
                      'color': ColorManager.orange,
                      'navigateTo': RouteManger.teacherChatsScreen,
                      'value': (stats?.monthlyRevenue ?? 0).toInt(),
                      'label': l10.revenue,
                      'description': l10.totalRevenue(
                        (stats?.monthlyRevenue ?? 0).toInt(),
                      ),
                    },
                    {
                      'icon': Icons.calendar_today_outlined,
                      'color': ColorManager.purple,
                      'navigateTo': RouteManger.teacherProfileScreen,
                      'value': stats?.todaysClasses ?? 0,
                      'label': l10.todaysClasses,
                      'description': l10.totalNumberOfTodaysClasses(
                        stats?.todaysClasses ?? 0,
                      ),
                    },
                  ];

                  return GridView.builder(
                    itemCount: statCardData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                        ),
                    itemBuilder: (context, index) {
                      final data = statCardData[index];
                      return StatCard(
                        icon: data['icon'] as IconData,
                        color: data['color'] as Color,
                        navigateTo: data['navigateTo'] as String,
                        value: data['value'] as int,
                        label: data['label'] as String,
                        description: data['description'] as String,
                      );
                    },
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
