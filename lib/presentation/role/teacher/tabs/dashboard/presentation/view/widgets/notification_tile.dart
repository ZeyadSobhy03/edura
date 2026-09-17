import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/teacher_notification/notification_model.dart';

enum NotificationAction { pin, details, delete }

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    required this.onAction,
  });

  final NotificationModel notification;
  final ValueChanged<NotificationAction> onAction;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.gray.withValues(alpha: .2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            notification.isPinned ? Icons.push_pin : Icons.notifications,
            color: ColorManager.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(notification.message, maxLines: 2),
              ],
            ),
          ),
          PopupMenuButton<NotificationAction>(
            color: ColorManager.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onSelected: onAction,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: NotificationAction.pin,
                child: Text(notification.isPinned ? l10.unpin : l10.pin),
              ),
              PopupMenuItem(
                value: NotificationAction.details,
                child: Text(l10.details),
              ),
              PopupMenuItem(
                value: NotificationAction.delete,
                child: Text(l10.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
