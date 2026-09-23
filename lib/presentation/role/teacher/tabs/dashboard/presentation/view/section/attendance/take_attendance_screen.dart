import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/teacher/tabs/students/presentation/view_model/student/student_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../l10n/app_localizations.dart';

class TakeAttendanceScreen extends StatefulWidget {
  const TakeAttendanceScreen({super.key, required this.lesson});

  final LessonModel lesson;

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  final Map<String, bool> _presentMap = {};

  @override
  void initState() {
    super.initState();
    context.read<StudentCubit>().getStudents();
  }

  Future<void> _save() async {
    final entries = _presentMap.entries
        .map(
          (e) => {'studentId': e.key, 'status': e.value ? 'present' : 'absent'},
        )
        .toList();

    await context.read<StudentCubit>().markAttendance(
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
              Navigator.pop(context);
            } else if (state is StudentError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(l10.errorOccurred)));
            }
          },
          builder: (context, state) {
            if (state is StudentLoading) {
              return Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            }

            if (state is StudentLoaded) {
              final roster = state.students
                  .where((s) => s.grade == widget.lesson.grade)
                  .toList();

              for (final s in roster) {
                _presentMap.putIfAbsent(s.id, () => true);
              }

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
