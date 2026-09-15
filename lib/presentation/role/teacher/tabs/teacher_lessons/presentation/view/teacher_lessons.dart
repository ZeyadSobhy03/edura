import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/localization/error_messages.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_elevated_button.dart';
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

   Future<void> _openCreateHomework() async {
     await Navigator.pushNamed(context, RouteManger.createHomeworkScreen);
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

  Future<void> _deleteLesson(LessonModel lesson) async {
    final l10 = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10.deleteLesson),
        content: Text(l10.deleteLessonConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              l10.delete,
              style: const TextStyle(color: Colors.red),
            ),
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
        final isSubmitting = state is TeacherLessonsSubmitting;

        final publishedLessons = state is TeacherLessonsLoaded
            ? state.publishedLessons
            : <LessonModel>[];
        final draftLessons = state is TeacherLessonsLoaded
            ? state.draftLessons
            : <LessonModel>[];

        return Scaffold(
          backgroundColor: ColorManager.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomLabel(label: l10.lessons, fontSize: 18),
                      const Spacer(),

                      CustomElevatedButton(
                        text: l10.addLesson,
                        onPressed: isSubmitting ? null : _openAddLesson,
                        haveIcon: true,
                        icon: Icons.add,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TeacherLessonsTabSelector(
                    selected: selected,
                    onTabSelected: (tab) => setState(() => selected = tab),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : selected == TeacherLessonsTab.published
                            ? PublishedTab(
                                lessons: publishedLessons,
                                onEdit: _editLesson,
                                onDelete: _deleteLesson,
                                onHomework: _openHomework,
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
