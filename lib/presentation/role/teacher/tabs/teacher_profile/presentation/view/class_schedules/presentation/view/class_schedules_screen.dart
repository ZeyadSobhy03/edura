import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/grade_chip.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/presentation/view/widgets/schedules_tile.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/presentation/view/widgets/show_add_dialog.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/presentation/view_model/grade_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../view_model/class_schedules_view_model.dart';

const _days = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
];

class ScheduleClassScreen extends StatefulWidget {
  const ScheduleClassScreen({super.key});

  @override
  State<ScheduleClassScreen> createState() => _ScheduleClassScreenState();
}

class _ScheduleClassScreenState extends State<ScheduleClassScreen> {
  String? _gradeId;

  @override
  void initState() {
    super.initState();
    context.read<GardeCubit>().fetchGrades(
      teacherId: Supabase.instance.client.auth.currentUser?.id ?? '',
    );
  }

  void _selectGrade(String gradeId) {
    setState(() => _gradeId = gradeId);
    context.read<ScheduleCubit>().load(gradeId);
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
          text: l10.classSchedules,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: _gradeId == null
          ? null
          : FloatingActionButton(
              backgroundColor: ColorManager.primary,
              onPressed: () {
                showAddScheduleDialog(
                  context: context,
                  gradeId: _gradeId!,
                  scheduleCubit: context.read<ScheduleCubit>(),
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
      body: SafeArea(
        child: Column(
          children: [
            BlocConsumer<GardeCubit, GradesState>(
              listener: (context, state) {
                if (state is GradesLoaded &&
                    state.grades.isNotEmpty &&
                    _gradeId == null) {
                  _selectGrade(state.grades.first.id);
                }
              },
              builder: (context, state) {
                if (state is GradesLoaded) {
                  if (state.grades.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        l10.noGradesFound,
                        style: TextStyle(
                          color: ColorManager.black.withValues(alpha: 0.5),
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    height: 44,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.grades.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, i) {
                        final g = state.grades[i];
                        return GradeChip(
                          label: g.name,
                          selected: g.id == _gradeId,
                          onTap: () => _selectGrade(g.id),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox(height: 44);
              },
            ),
            const SizedBox(height: 12),

            Expanded(
              child: BlocConsumer<ScheduleCubit, ScheduleState>(
                listener: (context, state) {
                  if (state is ScheduleError) {
                    Fluttertoast.showToast(
                      msg: state.message,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ScheduleLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primary,
                      ),
                    );
                  }
                  if (state is ScheduleLoaded) {
                    if (state.schedules.isEmpty) {
                      return Center(
                        child: CustomText(
                          text: l10.noSchedulesFound,
                          style: TextStyle(
                            color: ColorManager.black.withValues(alpha: 0.5),
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.schedules.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, i) {
                        final s = state.schedules[i];
                        return SchedulesTile(
                          day: _days[s.dayOfWeek],
                          onDelete: () => context.read<ScheduleCubit>().delete(
                            id: s.id,
                            gradeId: s.gradeId,
                          ),
                          schedule: s,
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
