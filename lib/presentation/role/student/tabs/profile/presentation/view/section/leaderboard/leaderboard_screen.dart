import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view/section/leaderboard/widgets/leaderboard_podium.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../l10n/app_localizations.dart';
import '../../../view_model/leaderboard/leaderboard_view_model.dart';
import 'leaderboard_list_tile.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LeaderboardCubit>().load();
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
          text: l10.leaderboard,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<LeaderboardCubit, LeaderboardState>(
          builder: (context, state) {
            if (state is LeaderboardLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            }
            if (state is LeaderboardError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message, textAlign: TextAlign.center),
                    TextButton(
                      onPressed: () => context.read<LeaderboardCubit>().load(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state is! LeaderboardLoaded || state.entries.isEmpty) {
              return Center(
                child: CustomText(
                  text: l10.noLeaderboardData,
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.5),
                    fontSize: 14,
                  ),
                ),
              );
            }

            final sorted = [...state.entries]
              ..sort((a, b) => a.rank.compareTo(b.rank));
            final showPodium = sorted.length >= 3;
            //   final topThree = showPodium ? sorted.take(3).toList() : <dynamic>[];
            final rest = showPodium ? sorted.skip(3).toList() : sorted;

            return RefreshIndicator(
              onRefresh: () => context.read<LeaderboardCubit>().load(
                teacherId: state.selectedTeacherId,
              ),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [
                  if (state.teachers.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Wrap(
                        spacing: 8,
                        children: state.teachers
                            .map(
                              (t) => ChoiceChip(
                                label: Text(t.name),
                                selected: t.id == state.selectedTeacherId,
                                onSelected: (_) => context
                                    .read<LeaderboardCubit>()
                                    .load(teacherId: t.id),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  if (showPodium) ...[
                    LeaderboardPodium(topThree: sorted.take(3).toList()),
                    const SizedBox(height: 20),
                  ],
                  ...rest.map((entry) => LeaderboardListTile(entry: entry)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
