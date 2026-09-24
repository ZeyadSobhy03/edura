import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/core/widgets/grade_chip.dart';
import 'package:edura/presentation/role/teacher/tabs/students/data/model/student_attendance_history.dart';
import 'package:edura/presentation/role/teacher/tabs/students/presentation/view_model/student/student_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/presentation/view_model/grade_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../../l10n/app_localizations.dart';

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({super.key});

  @override
  State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  String? _selectedGrade;
  String _query = '';

  @override
  void initState() {
    super.initState();
    context.read<GardeCubit>().fetchGrades(
      teacherId: Supabase.instance.client.auth.currentUser?.id ?? '',
    );
  }

  void _selectGrade(String grade) {
    setState(() => _selectedGrade = grade);
    context.read<StudentCubit>().getAttendanceHistoryForGrade(grade: grade);
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
          text: l10.attendanceReport,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            BlocConsumer<GardeCubit, GradesState>(
              listener: (context, state) {
                if (state is GradesLoaded &&
                    state.grades.isNotEmpty &&
                    _selectedGrade == null) {
                  _selectGrade(state.grades.first.name);
                }
              },
              builder: (context, state) {
                if (state is GradesLoading) {
                  return SizedBox(
                    height: 44,
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  );
                }

                if (state is GradesError) {
                  return SizedBox(
                    height: 44,
                    child: Center(child: Text(state.message)),
                  );
                }

                if (state is GradesLoaded) {
                  if (state.grades.isEmpty) {
                    return SizedBox(
                      height: 44,
                      child: Center(child: Text(l10.noGradesYet)),
                    );
                  }
                  return SizedBox(
                    height: 44,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.grades.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final name = state.grades[index].name;
                        return GradeChip(
                          label: name,
                          selected: name == _selectedGrade,
                          onTap: () => _selectGrade(name),
                        );
                      },
                    ),
                  );
                }

                return const SizedBox(height: 44);
              },
            ),
            const SizedBox(height: 20,),

            CustomTextFormedField(
              hintText: l10.searchStudent,
              onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
              prefix: const Icon(Icons.search),
              filled: true,
            ),

            Expanded(
              child: BlocBuilder<StudentCubit, StudentState>(
                builder: (context, state) {
                  if (state is StudentLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primary,
                      ),
                    );
                  }

                  if (state is AttendanceHistoryLoaded) {
                    final students = state.history
                        .where(
                          (s) => s.studentName.toLowerCase().contains(_query),
                        )
                        .toList();

                    if (students.isEmpty) {
                      return Center(
                        child: CustomText(
                          text: l10.noStudentsFound,
                          style: TextStyle(
                            color: ColorManager.black.withValues(alpha: 0.5),
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: students.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) =>
                          _StudentAttendanceTile(student: students[index]),
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

class _StudentAttendanceTile extends StatelessWidget {
  const _StudentAttendanceTile({required this.student});

  final StudentAttendanceHistory student;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final presentCount = student.records
        .where((r) => r.status == 'present')
        .length;
    final totalCount = student.records.length;

    return Container(
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        title: CustomText(
          text: student.studentName,
          style: TextStyle(
            color: ColorManager.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: CustomText(
          text: '$presentCount/$totalCount ${l10.present}',
          style: TextStyle(
            color: ColorManager.black.withValues(alpha: 0.5),
            fontSize: 12,
          ),
        ),
        children: student.records.isEmpty
            ? [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12, left: 16),
                  child: CustomText(
                    text: l10.noAttendanceRecords,
                    style: TextStyle(
                      color: ColorManager.black.withValues(alpha: 0.4),
                      fontSize: 13,
                    ),
                  ),
                ),
              ]
            : student.records.map((record) {
                final isPresent = record.status == 'present';
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: DateFormat('MMM d, yyyy').format(record.date),
                          style: TextStyle(
                            color: ColorManager.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isPresent
                              ? Colors.green.withValues(alpha: 0.15)
                              : Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: CustomText(
                          text: isPresent ? l10.present : l10.absent,
                          style: TextStyle(
                            color: isPresent ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
      ),
    );
  }
}
