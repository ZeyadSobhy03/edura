import 'package:edura/core/model/notification_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import 'notification_category_style.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.item, this.onDelete});
  final NotificationModel item;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final style = NotificationCategoryStyle.of(item.category);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: style.color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(style.icon, color: style.color, size: 18),
        ),
        SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomText(
                      text: item.title,
                      style: TextStyle(
                        color: ColorManager.black,
                        fontWeight:
                        item.isRead ? FontWeight.normal : FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  // unread dot moved next to title like your screenshot
                  if (!item.isRead)
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(left: 6, top: 4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              CustomText(
                text: item.message,
                style: TextStyle(
                  color: ColorManager.black.withValues(alpha: 0.6),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              CustomText(
                text: item.time,
                style: TextStyle(
                  color: ColorManager.black.withValues(alpha: 0.4),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        IconButton(
          icon: Icon(
            Icons.close,
            size: 18,
            color: ColorManager.black.withValues(alpha: 0.4),
          ),
          onPressed: onDelete,
        ),
      ],
    );
  }
}