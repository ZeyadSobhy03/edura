import 'package:edura/core/extensions/text_ex.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/teacher_notification/notification_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../../../l10n/app_localizations.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({
    super.key,
    required this.announcement,
    this.haveDivider = true,
    this.onTap,
    this.onDelete,
  });

  final NotificationModel announcement;
  final bool haveDivider;

  final VoidCallback? onTap;

  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final isPinned = announcement.isPinned;
    final isRead = announcement.isRead;
    final l10 = AppLocalizations.of(context)!;

    final card = Card(
      color: ColorManager.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isPinned
              ? ColorManager.primary
              : ColorManager.gray.withValues(alpha: 0.2),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isPinned)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.push_pin,
                        color: ColorManager.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      CustomText(
                        text: l10.pinned,
                        style: TextStyle(
                          color: ColorManager.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Unread dot
                  if (!isRead)
                    Padding(
                      padding: const EdgeInsets.only(top: 5, right: 8),
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: ColorManager.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  Expanded(
                    child: CustomText(
                      text: announcement.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                        fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CustomText(
                    text: announcement.time.formatDate,
                    style: TextStyle(
                      color: ColorManager.black.withValues(alpha: 0.5),
                      fontSize: 12,
                    ),
                  ),
                  // Delete button
                  if (onDelete != null)
                    InkWell(
                      onTap: onDelete,
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.delete_outline,
                          size: 20,
                          color: ColorManager.black.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),

              Flexible(
                fit: FlexFit.loose,
                child: CustomText(
                  text: announcement.message,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.75),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),

              if (haveDivider)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Divider(
                      color: ColorManager.gray.withValues(alpha: 0.2),
                      thickness: 1,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      text: announcement.teacherName,
                      style: TextStyle(
                        color: ColorManager.black.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );

    if (onDelete == null) return card;

    return Dismissible(
      key: ValueKey(announcement.id),
      direction: DismissDirection.horizontal,
      onDismissed: (_) => onDelete!(),
      background: _dismissBackground(Alignment.centerLeft),
      secondaryBackground: _dismissBackground(Alignment.centerRight),
      child: card,
    );
  }

  Widget _dismissBackground(Alignment alignment) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: alignment,
      decoration: BoxDecoration(
        color: ColorManager.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.delete_outline, color: Colors.white),
    );
  }
}