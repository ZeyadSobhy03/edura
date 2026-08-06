import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/leaderboard/widgets/leaderboard_podium.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/model/leaderboard_entry_model.dart';
import '../../../../../../../l10n/app_localizations.dart';
import 'leaderboard_list_tile.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final entries = DummyLeaderboardData.all;
    final topThree = entries.where((e) => e.rank <= 3).toList()
      ..sort((a, b) => a.rank.compareTo(b.rank));
    final rest = entries.where((e) => e.rank > 3).toList()
      ..sort((a, b) => a.rank.compareTo(b.rank));

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.leaderboard,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: entries.isEmpty
            ? Center(
                child: CustomText(
                  text: l10.noLeaderboardData,
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.5),
                    fontSize: 14,
                  ),
                ),
              )
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (topThree.length == 3) ...[
                    LeaderboardPodium(topThree: topThree),
                    const SizedBox(height: 20),
                  ],
                  ...rest.map((entry) => LeaderboardListTile(entry: entry)),
                ],
              ),
      ),
    );
  }
}
