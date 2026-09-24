import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/teacher/tabs/students/presentation/view_model/student/student_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../../core/localization/error_messages.dart';
import '../../../../../../../../../l10n/app_localizations.dart';

class TakeAttendanceScreen extends StatefulWidget {
  const TakeAttendanceScreen({super.key, required this.lesson});

  final LessonModel lesson;

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  final Map<String, bool> _presentMap = {};

  Map<String, String>? _existingStatuses;

  bool get _alreadyTaken =>
      _existingStatuses != null && _existingStatuses!.isNotEmpty;

  @override
  void initState() {
    super.initState();
    context.read<StudentCubit>().getStudents();
    _loadExisting();
  }

  Future<void> _loadExisting() async {
    final existing = await context.read<StudentCubit>().getAttendanceForLesson(
      lessonId: widget.lesson.id,
      date: DateTime.now(),
    );
    if (!mounted) return;
    setState(() => _existingStatuses = existing);
  }

  Future<void> _save() async {
    final entries = _presentMap.entries
        .map(
          (e) => {'studentId': e.key, 'status': e.value ? 'present' : 'absent'},
        )
        .toList();

    await context.read<StudentCubit>().markAttendance(
      teacherId: Supabase.instance.client.auth.currentUser?.id ?? '',
      lessonId: widget.lesson.id,
      date: DateTime.now(),
      entries: entries,
    );
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
          text: l10.takeAttendance,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<StudentCubit, StudentState>(
          listener: (context, state) {
            if (state is AttendanceSaved) {
              Fluttertoast.showToast(
                msg: l10.attendanceSavedSuccessfully,
                backgroundColor: ColorManager.green,
                gravity: ToastGravity.BOTTOM,
                textColor: ColorManager.white,
              );
              Navigator.pop(context);
            } else if (state is StudentError) {
              Fluttertoast.showToast(
                msg: ErrorMessages.get(context, state.error),
                backgroundColor: ColorManager.red,
                gravity: ToastGravity.BOTTOM,
                textColor: ColorManager.white,
              );
            }
          },
          builder: (context, state) {
            // Wait for BOTH the roster and the existing-attendance check
            if (state is StudentLoading || _existingStatuses == null) {
              return Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            }

            if (state is StudentLoaded) {
              final roster = state.students
                  .where((s) => s.grade == widget.lesson.grade)
                  .toList();

              if (roster.isEmpty) {
                return Center(
                  child: CustomText(
                    text: l10.noStudentsFound,
                    style: TextStyle(
                      color: ColorManager.black.withValues(alpha: 0.5),
                    ),
                  ),
                );
              }

              if (_alreadyTaken) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Colors.orange,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: CustomText(
                                text: l10.attendanceAlreadyTaken,
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: roster.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final student = roster[index];
                          final status =
                              _existingStatuses![student.id] ?? 'present';
                          final isPresent = status == 'present';

                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: ColorManager.primary.withValues(
                                alpha: 0.04,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomText(
                                    text: student.name,
                                    style: TextStyle(
                                      color: ColorManager.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
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
                                      color: isPresent
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }

              for (final s in roster) {
                _presentMap.putIfAbsent(s.id, () => true);
              }

              final isSaving = state is AttendanceSaving;

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: roster.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final student = roster[index];
                        final isPresent = _presentMap[student.id] ?? true;

                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: ColorManager.primary.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomText(
                                  text: student.name,
                                  style: TextStyle(
                                    color: ColorManager.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              ChoiceChip(
                                label: Text(l10.present),
                                selected: isPresent,
                                selectedColor: Colors.green.withValues(
                                  alpha: 0.2,
                                ),
                                onSelected: (_) {
                                  setState(() {
                                    _presentMap[student.id] = true;
                                  });
                                },
                              ),
                              const SizedBox(width: 6),
                              ChoiceChip(
                                label: Text(l10.absent),
                                selected: !isPresent,
                                selectedColor: Colors.red.withValues(
                                  alpha: 0.2,
                                ),
                                onSelected: (_) {
                                  setState(() {
                                    _presentMap[student.id] = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isSaving ? null : _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isSaving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                l10.save,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
