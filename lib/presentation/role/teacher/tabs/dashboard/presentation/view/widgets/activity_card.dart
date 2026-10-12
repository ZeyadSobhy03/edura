import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/activities/recent_activity_model.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key, required this.activity, this.confirmDismiss, this.onDismissed});

  final RecentActivityModel activity;
  final Future<bool?> Function(DismissDirection)? confirmDismiss;
  final void Function(DismissDirection)? onDismissed;

  String _relativeTime(DateTime dt, BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return l10.justNow;
    if (diff.inMinutes < 60) return l10.minutesAgo(diff.inMinutes);
    if (diff.inHours < 24) return l10.hoursAgo(diff.inHours);
    return l10.daysAgo(diff.inDays);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(

      background: Container(
        color: ColorManager.red.withValues(alpha: 0.1),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: ColorManager.red),
      ),
      behavior: HitTestBehavior.opaque,
      key: ValueKey(activity.id),
      confirmDismiss:confirmDismiss ,
      onDismissed: onDismissed,
      child: Card(
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
      ),
    );
  }
}