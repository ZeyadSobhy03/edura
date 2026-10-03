
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../../core/widgets/stat_card.dart';
import '../../../../../../../../../l10n/app_localizations.dart';
import '../../../view_model/student_stats/student_stats_view_model.dart';

class StatsSection extends StatefulWidget {
  const StatsSection({super.key, required this.studentId});
  final String studentId;

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> {
  @override
  void initState() {
    context
        .read<StudentStatsCubit>()
        .fetchStats(studentId: widget.studentId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return BlocBuilder<StudentStatsCubit, StudentStatsState>(
      builder: (context, state) {
        int lessons = 0;
        int studyHours = 0;
        int averageScore = 0;

        if (state is StudentStatsLoaded) {
          lessons = state.stats.lessons;
          studyHours = state.stats.studyMinutes;
          averageScore = state.stats.averageScore;
        }

        return Column(
          children: [
            if (state is StudentStatsLoading)
              CircularProgressIndicator(
                color: ColorManager.primary,
              ),
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: l10.lessons,
                    value: lessons,
                    valueColor: ColorManager.primary,
                  ),
                ),
                Expanded(
                  child: StatCard(
                    title: l10.studyTime,
                    value: studyHours,
                    valueColor: ColorManager.purple,
                  ),
                ),
                Expanded(
                  child: StatCard(
                    title: l10.averageScore,
                    value: averageScore,
                    valueColor: ColorManager.green,
                  ),
                ),
              ],
            ),
            if (state is StudentStatsError)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        state.message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                    TextButton(
                      onPressed: () => context
                          .read<StudentStatsCubit>()
                          .fetchStats(studentId: widget.studentId),
                      child: Text(
                        l10.retry,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
