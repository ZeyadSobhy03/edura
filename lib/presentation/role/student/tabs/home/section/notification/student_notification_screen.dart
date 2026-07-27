import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/student/tabs/home/section/notification/widget/notification_item.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/model/notification_model.dart';
import '../../../../../../../l10n/app_localizations.dart';

class StudentNotificationScreen extends StatefulWidget {
  const StudentNotificationScreen({super.key});

  @override
  State<StudentNotificationScreen> createState() =>
      _StudentNotificationScreenState();
}

class _StudentNotificationScreenState extends State<StudentNotificationScreen> {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      title: 'New Course Available',
      message: 'A new course has been added to your dashboard.',
      time: '2h ago',
      category: NotificationCategory.exam
    ),
    NotificationModel(
      id: '2',
      title: 'Assignment Reminder',
      message: 'Your assignment is due tomorrow.',
      time: '5h ago',
      isRead: true,
      category: NotificationCategory.assignment
    ),
    NotificationModel(
      id: '3',
      title: 'Grade Posted',
      message: 'Your grade for Math 101 has been posted.',
      time: '1d ago',
      category: NotificationCategory.grade
    ),
  ];

  void _markAsRead(NotificationModel item) {
    setState(() {
      item.isRead = true;
    });
  }

  void _deleteNotification(NotificationModel item) {
    setState(() {
      _notifications.removeWhere((n) => n.id == item.id);
    });
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
                    onTap: () {
                      Navigator.pop(context);
                    },
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
              child: _notifications.isEmpty
                  ? Center(
                      child: CustomText(
                        text: l10.noNotifications,
                        style: TextStyle(
                          color: ColorManager.black.withValues(alpha: 0.5),
                          fontSize: 14,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _notifications.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = _notifications[index];
                        return Dismissible(
                          key: ValueKey(item.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: ColorManager.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (_) => _deleteNotification(item),
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
                                onDelete: () => _deleteNotification(item),
                              ),
                            ),
                          ),
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
