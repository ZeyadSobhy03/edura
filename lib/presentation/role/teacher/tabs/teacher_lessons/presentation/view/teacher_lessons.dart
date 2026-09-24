import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/localization/error_messages.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_label.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view/section/draft_tab.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view/section/published_tab.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view/widgets/teacher_lessons_tab_selector.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view_model/lessons/teacher_lessons_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../../l10n/app_localizations.dart';

class TeacherLessons extends StatefulWidget {
  const TeacherLessons({super.key});

  @override
  State<TeacherLessons> createState() => _TeacherLessonsState();
}

class _TeacherLessonsState extends State<TeacherLessons> {
  TeacherLessonsTab selected = TeacherLessonsTab.published;

  @override
  void initState() {
    super.initState();
    context.read<TeacherLessonsCubit>().fetchLessons();
  }

  Future<void> _openAddLesson() async {
    await Navigator.pushNamed(context, RouteManger.addNewLessonScreen);
    if (mounted) {
      context.read<TeacherLessonsCubit>().fetchLessons();
    }
  }

  Future<void> _editLesson(LessonModel lesson) async {
    await Navigator.pushNamed(
      context,
      RouteManger.editLessonScreen,
      arguments: lesson,
    );
    if (mounted) {
      context.read<TeacherLessonsCubit>().fetchLessons();
    }
  }

  void _openAttendance(LessonModel lesson) {
    Navigator.pushNamed(
      context,
      RouteManger.takeAttendanceScreen,
      arguments: lesson,
    );
  }

  void _showAddOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final l10 = AppLocalizations.of(context)!;
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    l10.addLesson,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 20),

                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: ColorManager.primary.withValues(
                      alpha: 0.1,
                    ),
                    child: Icon(
                      Icons.menu_book_rounded,
                      color: ColorManager.primary,
                    ),
                  ),
                  title: Text(
                    l10.addNewLesson,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(l10.addNewLesson),
                  onTap: () {
                    Navigator.pop(context);
                    _openAddLesson();
                  },
                ),

                const SizedBox(height: 8),

                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.withValues(alpha: 0.1),
                    child: const Icon(
                      Icons.assignment_rounded,
                      color: Colors.orange,
                    ),
                  ),
                  title: Text(
                    l10.addHomework,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(l10.addNewHomeWork),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushNamed(
                      context,
                      RouteManger.createHomeworkScreen,
                    );
                  },
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteLesson(LessonModel lesson) async {
    final l10 = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(l10.deleteLesson),
        content: Text(l10.deleteLessonConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              l10.cancel,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10.delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      context.read<TeacherLessonsCubit>().deleteLesson(lesson.id);
    }
  }

  void _openHomework(LessonModel lesson) {
    Navigator.pushNamed(
      context,
      RouteManger.teacherHomeworkScreen,
      arguments: lesson.homeworkSubmissions,
    );
  }

  void _publishDraft(LessonModel lesson) {
    context.read<TeacherLessonsCubit>().publishLesson(lesson);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return BlocConsumer<TeacherLessonsCubit, TeacherLessonsState>(
      listener: (context, state) {
        if (state is UpdateLessonSuccess) {
          Fluttertoast.showToast(msg: l10.lessonUpdatedSuccessfully);
          context.read<TeacherLessonsCubit>().fetchLessons();
        } else if (state is DeleteLessonSuccess) {
          Fluttertoast.showToast(msg: l10.lessonDeletedSuccessfully);
          context.read<TeacherLessonsCubit>().fetchLessons();
        } else if (state is UpdateLessonFailure ||
            state is DeleteLessonFailure) {
          final error = state is UpdateLessonFailure
              ? state.error
              : (state as DeleteLessonFailure).error;
          Fluttertoast.showToast(msg: ErrorMessages.get(context, error));
        } else if (state is TeacherLessonsFailure) {
          Fluttertoast.showToast(msg: ErrorMessages.get(context, state.error));
        }
      },
      builder: (context, state) {
        final isLoading = state is TeacherLessonsLoading;

        final publishedLessons = state is TeacherLessonsLoaded
            ? state.publishedLessons
            : <LessonModel>[];
        final draftLessons = state is TeacherLessonsLoaded
            ? state.draftLessons
            : <LessonModel>[];

        return Scaffold(
          backgroundColor: ColorManager.white,

          floatingActionButton: FloatingActionButton(
            onPressed: _showAddOptions,
            backgroundColor: ColorManager.primary,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [CustomLabel(label: l10.lessons, fontSize: 18)],
                  ),
                  const SizedBox(height: 16),
                  TeacherLessonsTabSelector(
                    selected: selected,
                    onTabSelected: (tab) => setState(() => selected = tab),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator(
                      color: ColorManager.primary,
                    ))
                        : selected == TeacherLessonsTab.published
                        ? PublishedTab(
                            lessons: publishedLessons,
                            onEdit: _editLesson,
                            onDelete: _deleteLesson,
                            onHomework: _openHomework,
                            onAttendance: _openAttendance,
                          )
                        : DraftTab(
                            drafts: draftLessons,
                            onEdit: _editLesson,
                            onDelete: _deleteLesson,
                            onPublish: _publishDraft,
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
