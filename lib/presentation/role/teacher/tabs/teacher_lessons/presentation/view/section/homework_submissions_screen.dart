
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/localization/error_messages.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/home_work/new_homework_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../student/tabs/lessons/data/model/student_home_work/homework_submission_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/home_work/submissions_view_model.dart';
import '../widgets/homework_stat_card.dart';
import '../widgets/submission_list_card.dart';

class HomeworkSubmissionsScreen extends StatefulWidget {
  const HomeworkSubmissionsScreen({super.key, required this.homework});

  final NewHomeworkModel homework;

  @override
  State<HomeworkSubmissionsScreen> createState() =>
      _HomeworkSubmissionsScreenState();
}

class _HomeworkSubmissionsScreenState extends State<HomeworkSubmissionsScreen> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() =>
      context.read<HomeworkSubmissionsCubit>().fetch(widget.homework.id);

  Future<void> _openReview(HomeworkSubmissionModel s) async {
    final reviewed = await Navigator.pushNamed(
      context,
      RouteManger.reviewHomeworkScreen,
      arguments: s,
    ) as bool?;

    if (reviewed == true && mounted) {
      _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: Text(widget.homework.title),
        backgroundColor: ColorManager.white,
      ),
      body: BlocBuilder<HomeworkSubmissionsCubit, HomeworkSubmissionsState>(
        builder: (context, state) {
          if (state is SubmissionsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          }
          if (state is SubmissionsFailure) {
            return Center(child: Text(ErrorMessages.get(context, state.error)));
          }

          final submissions = state is SubmissionsLoaded
              ? state.submissions
              : <HomeworkSubmissionModel>[];

          final pending = submissions
              .where((s) => s.status == SubmissionStatus.pending)
              .toList();
          final graded = submissions
              .where((s) => s.status == SubmissionStatus.graded)
              .toList();

          return RefreshIndicator(
            backgroundColor: ColorManager.white,
            onRefresh: _load,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: HomeworkStatCard(
                        count: pending.length,
                        label: l10.pendingReview,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: HomeworkStatCard(
                        count: graded.length,
                        label: l10.graded,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (submissions.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Center(child: Text(l10.noSubmissionsYet)),
                  )
                else
                  ...[...pending, ...graded].map(
                        (s) => SubmissionListCard(
                      submission: s,
                      onTap: () => _openReview(s),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}