import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../core/model/announcement_model.dart';
import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key, required this.announcement});

  final AnnouncementModel announcement;

  @override
  Widget build(BuildContext context) {
    final isPinned = announcement.isPinned;
    final l10 = AppLocalizations.of(context)!;

    return Card(
      color: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isPinned
              ? ColorManager.primary
              : ColorManager.gray.withValues(alpha: 0.2),
        ),
      ),
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
                    Icon(Icons.push_pin, color: ColorManager.primary, size: 16),
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
                Expanded(
                  child: CustomText(
                    text: announcement.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CustomText(
                  text: DateFormat('MMM d').format(announcement.date),
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Expanded(
              child: CustomText(
                text: announcement.description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: ColorManager.black.withValues(alpha: 0.75),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 8),
            Divider(color: ColorManager.gray.withValues(alpha: 0.2), thickness: 1),
            const SizedBox(height: 8),

            CustomText(
              text: announcement.author,
              style: TextStyle(
                color: ColorManager.black.withValues(alpha: 0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}