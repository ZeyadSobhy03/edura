import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/student/tabs/home/presentation/view/section/notification/widget/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../teacher/tabs/dashboard/data/model/teacher_notification/notification_model.dart';
import '../../../view_model/student_notification/student_notification_view_model.dart';


class StudentNotificationScreen extends StatefulWidget {
  const StudentNotificationScreen({super.key});

  @override
  State<StudentNotificationScreen> createState() =>
      _StudentNotificationScreenState();
}

class _StudentNotificationScreenState extends State<StudentNotificationScreen> {
  late final String _studentId;
  final Set<String> _hiddenIds = {};

  @override
  void initState() {
    super.initState();
    _studentId = Supabase.instance.client.auth.currentUser!.id;
    context.read<StudentNotificationCubit>().getNotificationsOfStudent(
      _studentId,
    );
  }


  void _markAsRead(NotificationModel item) {
    if (item.isRead) return;
    setState(() => item.isRead = true);
    context.read<StudentNotificationCubit>().markAsRead(item.id, _studentId);
  }

  void _dismiss(NotificationModel item) {
    setState(() => _hiddenIds.add(item.id));
  }
  void _delete(String notificationId) {
    context.read<StudentNotificationCubit>().deleteNotificationOfStudent(
      notificationId,
      _studentId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: ColorManager.black,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: CustomText(
                        text: l10.notifications,
                        style: TextStyle(
                          color: ColorManager.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<
                      StudentNotificationCubit,
                    StudentNotificationState
                  >(
                    builder: (context, state) {
                      if (state is StudentNotificationLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.primary,
                          ),
                        );
                      }

                      if (state is StudentNotificationError) {
                        return Center(
                          child: CustomText(
                            text: l10.errorOccurred,
                            style: TextStyle(color: ColorManager.red),
                          ),
                        );
                      }

                      final notifications = state is StudentNotificationLoaded
                          ? state.notifications
                                .where((n) => !_hiddenIds.contains(n.id))
                                .toList()
                          : <NotificationModel>[];

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
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: notifications.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final item = notifications[index];
                          return Dismissible(
                            key: ValueKey(item.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: ColorManager.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (_) => _dismiss(item),
                            child: InkWell(
                              onTap: () => _markAsRead(item),
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: item.isRead
                                      ? ColorManager.white
                                      : ColorManager.primary.withValues(
                                          alpha: 0.05,
                                        ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: ColorManager.black.withValues(
                                      alpha: 0.1,
                                    ),
                                  ),
                                ),
                                child: NotificationItem(
                                  item: item,
                                  onDelete: () => _delete(item.id),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
