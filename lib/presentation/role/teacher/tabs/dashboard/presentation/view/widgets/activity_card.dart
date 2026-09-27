import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/activities/recent_activity_model.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key, required this.activity});

  final RecentActivityModel activity;

  String _relativeTime(DateTime dt, BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return l10.justNow;
    if (diff.inMinutes < 60) return '${diff.inMinutes}${l10.minutesAgo(diff.inMinutes)}';
    if (diff.inHours < 24) return '${diff.inHours}${l10.hoursAgo(diff.inHours)}';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorManager.black.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(activity.icon, color: ColorManager.blue),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: activity.title,
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  CustomText(
                    text: activity.description,
                    style: TextStyle(
                      color: ColorManager.black.withValues(alpha: 0.6),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    text: _relativeTime(activity.timestamp,context),
                    style: TextStyle(color: ColorManager.salatGray, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}