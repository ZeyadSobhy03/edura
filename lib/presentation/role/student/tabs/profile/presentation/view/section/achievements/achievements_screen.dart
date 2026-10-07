import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../l10n/app_localizations.dart';
import '../../../view_model/achievements/achievements_view_model.dart';
import 'section/achievement_badge_card.dart';
import 'section/achievements_stats_banner.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AchievementsCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.achievements,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<AchievementsCubit, AchievementsState>(
          builder: (context, state) {
            if (state is AchievementsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            }
            if (state is AchievementsError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message, textAlign: TextAlign.center),
                    TextButton(
                      onPressed: () =>
                          context.read<AchievementsCubit>().load(),
                      child:  Text(l10.retry),
                    ),
                  ],
                ),
              );
            }
            if (state is! AchievementsLoaded) return const SizedBox.shrink();

            final achievements = state.achievements;
            final earnedCount = achievements.where((a) => a.isEarned).length;

            return RefreshIndicator(
              onRefresh: () => context.read<AchievementsCubit>().load(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AchievementsStatsBanner(
                      points: state.points,
                      rank: state.rank,
                      badgesEarned: earnedCount,
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: achievements.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, index) => AchievementBadgeCard(
                        achievement: achievements[index],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}