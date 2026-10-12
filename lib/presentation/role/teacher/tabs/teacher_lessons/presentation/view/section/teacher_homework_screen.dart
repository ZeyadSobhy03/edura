import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/localization/error_messages.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/home_work/new_homework_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view_model/home_work/home_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class TeacherHomeworkScreen extends StatefulWidget {
  const TeacherHomeworkScreen({super.key, this.lessonId});

  final String? lessonId;

  @override
  State<TeacherHomeworkScreen> createState() => _TeacherHomeworkScreenState();
}

class _TeacherHomeworkScreenState extends State<TeacherHomeworkScreen> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final cubit = context.read<HomeWorkCubit>();
    final id = widget.lessonId;
    if (id != null) {
      await cubit.fetchHomeworks(id);
    } else {
      await cubit.getAllHomeworks();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: Text(l10.homework),
        backgroundColor: ColorManager.white,
      ),
      body: BlocBuilder<HomeWorkCubit, HomeWorkState>(
        buildWhen: (previous, current) =>
        current is HomeWorkInitial ||
            current is HomeWorkLoading ||
            current is HomeWorkLoaded ||
            current is HomeWorkFailure,
        builder: (context, state) {
          if (state is HomeWorkLoading || state is HomeWorkInitial) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          }
          if (state is HomeWorkFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(ErrorMessages.get(context, state.error)),
                  TextButton(onPressed: _load, child: const Text('Retry')),
                ],
              ),
            );
          }

          final homeworks =
          state is HomeWorkLoaded ? state.homeworks : <NewHomeworkModel>[];

          return RefreshIndicator(
            onRefresh: _load,
            child: homeworks.isEmpty
                ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 300,
                  child: Center(child: Text(l10.noHomeworkYet)),
                ),
              ],
            )
                : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: homeworks.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final hw = homeworks[i];
                return Card(
                  elevation: 0,
                  color: ColorManager.gray.withValues(alpha: 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    title: Text(
                      hw.title,
                      style:
                      const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: hw.dueDate == null
                        ? null
                        : Text(DateFormat.yMMMd()
                        .format(hw.dueDate!.toLocal())),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        RouteManger.homeworkSubmissionsScreen,
                        arguments: hw,
                      );
                      if (mounted) _load();
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}