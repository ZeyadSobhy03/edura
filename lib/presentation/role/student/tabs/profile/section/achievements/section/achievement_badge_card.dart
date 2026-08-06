import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../core/model/achievement_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class AchievementBadgeCard extends StatelessWidget {
  const AchievementBadgeCard({super.key, required this.achievement});

  final AchievementModel achievement;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final isEarned = achievement.isEarned;

    return Opacity(
      opacity: isEarned ? 1.0 : 0.55,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
        ),
        child: Column(
          children: [
            CustomText(
              text: achievement.emoji,
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 8),
            CustomText(
              text: achievement.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: ColorManager.black,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            CustomText(
              text: achievement.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorManager.black.withValues(alpha: 0.5),
                fontSize: 10.5,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            CustomText(
              text: isEarned && achievement.earnedDate != null
                  ? DateFormat('MMM d').format(achievement.earnedDate!)
                  : l10.locked,
              style: TextStyle(
                color: isEarned ? ColorManager.primary : ColorManager.gray,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
