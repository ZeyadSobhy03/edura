import 'package:edura/core/model/homework_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_list_tail.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/class_schedule_model.dart';
import '../../../../../../l10n/app_localizations.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Card(
      color: ColorManager.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: ColorManager.black.withValues(alpha: 0.1),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomListTail(
              text: l10.leaderboard,
              subTitle: l10.rank,
              icon: Icons.emoji_events_outlined,
              iconColor: ColorManager.primary,
              onTap: () {
                Navigator.pushNamed(context, RouteManger.leaderboardScreen);
              },
            ),
            Divider(color: ColorManager.gray.withValues(alpha: 0.2)),
            CustomListTail(
              text: l10.schedule,
              subTitle: l10.numberOfClassToday(3),
              icon: Icons.calendar_today_outlined,
              iconColor: ColorManager.purple,
              onTap: () {
                Navigator.pushNamed(context, RouteManger.scheduleScreen,
                arguments: DummyScheduleData.all
                );
              },
            ),
            Divider(color: ColorManager.gray.withValues(alpha: 0.2)),

            CustomListTail(
              text: l10.homework,
              subTitle: l10.numberOfHomework(2),
              icon: Icons.description_outlined,
              iconColor: ColorManager.red,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteManger.homeWorkScreen,
                  arguments: DummyHomeworkData.all,
                );
              },
            ),
            Divider(color: ColorManager.gray.withValues(alpha: 0.2)),

            CustomListTail(
              onTap: (){
                Navigator.pushNamed(context, RouteManger.achievementScreen);
              },
              text: l10.achievements,
              subTitle: l10.numberOfAchievements(5),
              icon: Icons.emoji_events_outlined,
              iconColor: ColorManager.green,
            ),
            Divider(color: ColorManager.gray.withValues(alpha: 0.2)),

            CustomListTail(
              onTap: (){
                Navigator.pushNamed(context, RouteManger.notesScreen);
              },
              text: l10.notes,
              subTitle: l10.personalStudyNotes,
              icon: Icons.menu_book_outlined,
              iconColor: ColorManager.orange,
            ),
            Divider(color: ColorManager.gray.withValues(alpha: 0.2)),
            CustomListTail(
              onTap: (){
                Navigator.pushNamed(context, RouteManger.attendanceScreen);
              },
              text: l10.attendance,
              subTitle: l10.attendanceScore(95),
              icon: Icons.insert_chart_outlined,
              iconColor: ColorManager.green,
            ),
            Divider(color: ColorManager.gray.withValues(alpha: 0.2)),

            CustomListTail(
              text: l10.announcements,
              subTitle: l10.numberOfAnnouncements(3),
              icon: Icons.location_on_outlined,
              iconColor: ColorManager.blue,
              onTap: () {
                Navigator.pushNamed(context, RouteManger.announcementsScreen);
              },
            ),
            Divider(color: ColorManager.gray.withValues(alpha: 0.2)),

            CustomListTail(
              onTap: (){
                Navigator.pushNamed(context, RouteManger.settingsScreen);
              },
              text: l10.setting,
              subTitle: l10.accountSettings,
              icon: Icons.settings_outlined,
              iconColor: ColorManager.gray.withValues(alpha: 0.8),
            ),
          ],
        ),
      ),
    );
  }
}
