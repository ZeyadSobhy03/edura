import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../teacher/tabs/dashboard/data/model/teacher_notification/notification_model.dart';
import '../../../view_model/student_notification/student_notification_view_model.dart';
import 'section/announcement_card.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  String? studentId;
  final Set<String> _hiddenIds = {};

  @override
  void initState() {
    super.initState();

    studentId = Supabase.instance.client.auth.currentUser?.id;

    if (studentId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Navigator.pop(context);
      });
      return;
    }

    context.read<StudentNotificationCubit>().getNotificationsOfStudent(
      studentId!,
    );
  }

  void _markAsRead(NotificationModel item) {
    final id = studentId;
    if (id == null || item.isRead) return;

    setState(() => item.isRead = true);
    context.read<StudentNotificationCubit>().markAsRead(item.id, id);
  }

  void _delete(String notificationId) {
    final id = studentId;
    if (id == null) return;

    context.read<StudentNotificationCubit>().deleteNotificationOfStudent(
      notificationId,
      id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        centerTitle: true,
        title: CustomText(
          text: l10.announcements,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<StudentNotificationCubit, StudentNotificationState>(
          builder: (context, state) {
            if (state is StudentNotificationLoading) {
              return Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            } else if (state is StudentNotificationLoaded) {
              final announcements = state.notifications
                  .where((n) => !_hiddenIds.contains(n.id))
                  .toList();

              if (announcements.isEmpty) {
                return Center(
                  child: CustomText(
                    text: l10.noAnnouncements,
                    style: TextStyle(color: ColorManager.gray, fontSize: 14),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: announcements.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final announcement = announcements[index];
                  return AnnouncementCard(
                    key: ValueKey(announcement.id),
                    announcement: announcement,
                    onTap: () => _markAsRead(announcement),
                    onDelete: () => _delete(announcement.id),
                  );
                },
              );
            } else if (state is StudentNotificationError) {
              return Center(
                child: CustomText(
                  text: state.message,
                  style: TextStyle(color: ColorManager.red, fontSize: 14),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
