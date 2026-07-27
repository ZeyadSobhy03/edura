import 'package:flutter/material.dart';

import '../../../../../../../../core/model/notification_model.dart';

class NotificationCategoryStyle {
  final IconData icon;
  final Color color;

  const NotificationCategoryStyle({required this.icon, required this.color});

  static NotificationCategoryStyle of(NotificationCategory category) {
    switch (category) {
      case NotificationCategory.lesson:
        return const NotificationCategoryStyle(
          icon: Icons.menu_book_rounded,
          color: Colors.blue,
        );
      case NotificationCategory.exam:
        return const NotificationCategoryStyle(
          icon: Icons.assignment_rounded,
          color: Colors.deepPurple,
        );
      case NotificationCategory.assignment:
        return const NotificationCategoryStyle(
          icon: Icons.edit_note_rounded,
          color: Colors.orange,
        );
      case NotificationCategory.grade:
        return const NotificationCategoryStyle(
          icon: Icons.grade_rounded,
          color: Colors.green,
        );
      case NotificationCategory.payment:
        return const NotificationCategoryStyle(
          icon: Icons.payment_rounded,
          color: Colors.teal,
        );
      case NotificationCategory.announcement:
        return const NotificationCategoryStyle(
          icon: Icons.campaign_rounded,
          color: Colors.red,
        );
      case NotificationCategory.general:
        return const NotificationCategoryStyle(
          icon: Icons.notifications_rounded,
          color: Colors.grey,
        );
    }
  }
}