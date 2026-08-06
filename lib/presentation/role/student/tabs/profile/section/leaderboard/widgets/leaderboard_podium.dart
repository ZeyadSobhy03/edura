import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/model/leaderboard_entry_model.dart';

class LeaderboardPodium extends StatelessWidget {
  const LeaderboardPodium({super.key, required this.topThree});

  final List<LeaderboardEntryModel> topThree;

  Widget _podiumSpot({
    required LeaderboardEntryModel entry,
    required double avatarSize,
    required double barHeight,
    required Color medalColor,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: avatarSize,
            backgroundColor: medalColor.withValues(alpha: 0.15),
            backgroundImage: entry.avatarUrl != null
                ? NetworkImage(entry.avatarUrl!)
                : null,
            child: entry.avatarUrl == null
                ? Icon(Icons.person, color: medalColor, size: avatarSize)
                : null,
          ),
          const SizedBox(height: 6),
          CustomText(
            text: entry.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorManager.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          CustomText(
            text: '${entry.points} pts',
            style: TextStyle(
              color: ColorManager.black.withValues(alpha: 0.5),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: barHeight,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: medalColor.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 8),
            child: Icon(Icons.emoji_events, color: medalColor, size: 18),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (topThree.length < 3) return const SizedBox.shrink();

    final first = topThree.firstWhere((e) => e.rank == 1);
    final second = topThree.firstWhere((e) => e.rank == 2);
    final third = topThree.firstWhere((e) => e.rank == 3);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _podiumSpot(
            entry: second,
            avatarSize: 26,
            barHeight: 60,
            medalColor: const Color(0xFFB0B0B0),
          ),
          _podiumSpot(
            entry: first,
            avatarSize: 32,
            barHeight: 80,
            medalColor: const Color(0xFFFFC107), // gold
          ),
          _podiumSpot(
            entry: third,
            avatarSize: 24,
            barHeight: 45,
            medalColor: const Color(0xFFCD7F32), // bronze
          ),
        ],
      ),
    );
  }
}
