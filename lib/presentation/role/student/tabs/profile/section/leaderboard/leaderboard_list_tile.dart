import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/model/leaderboard_entry_model.dart';


class LeaderboardListTile extends StatelessWidget {
  const LeaderboardListTile({super.key, required this.entry});

  final LeaderboardEntryModel entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: entry.isCurrentUser
            ? ColorManager.primary.withValues(alpha: 0.06)
            : ColorManager.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: entry.isCurrentUser
              ? ColorManager.primary.withValues(alpha: 0.4)
              : ColorManager.gray.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: CustomText(
              text: '${entry.rank}',
              style: TextStyle(
                color: ColorManager.black.withValues(alpha: 0.5),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CircleAvatar(
            radius: 18,
            backgroundColor: ColorManager.primary.withValues(alpha: 0.1),
            backgroundImage:
            entry.avatarUrl != null ? NetworkImage(entry.avatarUrl!) : null,
            child: entry.avatarUrl == null
                ? Icon(Icons.person, color: ColorManager.primary, size: 18)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomText(
              text: entry.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: ColorManager.black,
                fontSize: 14,
                fontWeight: entry.isCurrentUser ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
          CustomText(
            text: '${entry.points} pts',
            style: TextStyle(
              color: ColorManager.primary,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}