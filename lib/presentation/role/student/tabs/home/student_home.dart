import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_label.dart';
import 'package:edura/core/widgets/custom_text_button.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/role/student/tabs/home/section/announcements/section/announcement_card.dart';
import 'package:edura/presentation/role/student/tabs/home/section/up_next_card.dart';
import 'package:edura/presentation/role/student/tabs/home/widgets/home_header.dart';
import 'package:edura/presentation/role/student/tabs/home/widgets/quick_action_card.dart';
import 'package:edura/core/widgets/stat_card.dart';
import 'package:edura/presentation/role/student/tabs/lessons/section/lesson_grid_card.dart';
import 'package:flutter/material.dart';

import '../../../../../core/model/announcement_model.dart';
import '../../../../../core/model/lesson_model.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final announcements = DummyAnnouncementData.all
        .where((element) => element.isPinned)
        .toList();
    final length = announcements.length;

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                userName: "Ziyad Sobhy",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteManger.studentNotificationScreen,
                  );
                },
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: l10.lessons,
                      value: 24,
                      valueColor: ColorManager.primary,
                    ),
                  ),
                  Expanded(
                    child: StatCard(
                      title: l10.studyTime,
                      value: 20,
                      valueColor: ColorManager.purple,
                    ),
                  ),
                  Expanded(
                    child: StatCard(
                      title: l10.averageScore,
                      value: 98,
                      valueColor: ColorManager.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              UpNextCard(
                title: 'الدرس الاول',
                duration: 30,
                subject: "math",
                progress: 0.2,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteManger.lessonDetails,
                    arguments: DummyLessonData.calculusDerivatives,
                  );
                },
              ),
              const SizedBox(height: 8),
              CustomLabel(label: l10.quickActions),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: QuickActionCard(
                      label: l10.lessons,
                      icon: Icons.menu_book,
                      color: ColorManager.primary,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteManger.studentMainLayoutRoute,
                          arguments: 1,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: QuickActionCard(
                      label: l10.exams,
                      icon: Icons.assignment,
                      color: ColorManager.purple,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteManger.studentMainLayoutRoute,
                          arguments: 2,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: QuickActionCard(
                      label: l10.chat,
                      icon: Icons.chat_bubble_outline,
                      color: ColorManager.orange,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteManger.studentMainLayoutRoute,
                          arguments: 3,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: QuickActionCard(
                      label: l10.schedule,
                      icon: Icons.schedule,
                      color: ColorManager.green,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteManger.studentMainLayoutRoute,
                          arguments: 4,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CustomLabel(label: l10.recentLessons),
                  const Spacer(),
                  CustomTextButton(
                    text: l10.viewAll,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.studentMainLayoutRoute,
                        arguments: 1,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: DummyLessonData.all.length,
                  itemBuilder: (context, index) {
                    final lesson = DummyLessonData.all[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(
                        width: 160,
                        child: LessonGridCard(
                          lesson: lesson,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteManger.lessonDetails,
                              arguments: lesson,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CustomLabel(label: l10.announcements),
                  const Spacer(),
                  CustomTextButton(
                    text: l10.viewAll,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.announcementsScreen,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: length,
                itemBuilder: (context, index) {
                  final isPinnedList = announcements;
                  if (isPinnedList.isNotEmpty) {
                    final pinnedAnnouncement = isPinnedList[index];
                    return AnnouncementCard(
                      haveDivider: false,
                      announcement: pinnedAnnouncement,
                    );
                  } else {
                    return Center(child: Text(l10.noAnnouncements));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
