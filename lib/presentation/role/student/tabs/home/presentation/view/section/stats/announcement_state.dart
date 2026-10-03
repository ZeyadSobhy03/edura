import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../../core/resources/routes/route_manger.dart';
import '../../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../../l10n/app_localizations.dart';
import '../../../view_model/student_notification/student_notification_view_model.dart';
import '../announcements/section/announcement_card.dart';

class AnnouncementState extends StatefulWidget {
  const AnnouncementState({super.key});

  @override
  State<AnnouncementState> createState() => _AnnouncementStateState();
}

class _AnnouncementStateState extends State<AnnouncementState> {
  String? studentId;

  @override
  void initState() {
    super.initState();
    studentId = Supabase.instance.client.auth.currentUser?.id;
    if (studentId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushNamed(context, RouteManger.loginRoute);
        }
      });
      return;
    }
    context.read<StudentNotificationCubit>().getNotificationsOfStudent(
      studentId!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return BlocBuilder<StudentNotificationCubit, StudentNotificationState>(
      builder: (context, state) {
        if (state is StudentNotificationLoading) {
          return const Center(
            child: CircularProgressIndicator(color: ColorManager.primary),
          );
        }
        if (state is StudentNotificationError) {
          return Center(
            child: CustomText(
              text: state.message,
              style: TextStyle(color: ColorManager.red),
            ),
          );
        }
        if (state is StudentNotificationLoaded) {
          final notifications = state.notifications;
          if (notifications.isEmpty) {
            return Center(
              child: CustomText(
                text: l10.noNotifications,
                style: TextStyle(
                  color: ColorManager.black.withValues(alpha: 0.5),
                  fontSize: 14,
                ),
              ),
            );
          } else {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                final announcement = notifications[index];
                return AnnouncementCard(
                  haveDivider: false,
                  announcement: announcement,
                );
              },
            );
          }
        }
        return SizedBox.shrink();
      },
    );
  }
}
