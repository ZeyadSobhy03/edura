import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_elevated_button.dart';
import 'package:edura/core/widgets/custom_label.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view/section/draft_tab.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view/section/published_tab.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view/widgets/teacher_lessons_tab_selector.dart';
import 'package:flutter/material.dart';

import '../../../../../../../l10n/app_localizations.dart';

class TeacherLessons extends StatefulWidget {
  const TeacherLessons({super.key});

  @override
  State<TeacherLessons> createState() => _TeacherLessonsState();
}

class _TeacherLessonsState extends State<TeacherLessons> {
  TeacherLessonsTab selected = TeacherLessonsTab.published;

  final List<LessonModel> _publishedLessons = DummyLessonData.all;
  final List<LessonModel> _draftLessons = [];

  void _editLesson(LessonModel lesson) {
    Navigator.pushNamed(
      context,
      RouteManger.editLessonScreen,
      arguments: lesson,
    );
  }

  void _deleteLesson(LessonModel lesson, {required bool isDraft}) {
    setState(() {
      if (isDraft) {
        _draftLessons.removeWhere((l) => l.id == lesson.id);
      } else {
        _publishedLessons.removeWhere((l) => l.id == lesson.id);
      }
    });
  }

  void _openHomework(LessonModel lesson) {
    Navigator.pushNamed(
      context,
      RouteManger.teacherHomeworkScreen,
      arguments: lesson.homeworkSubmissions,
    );
  }

  void _publishDraft(LessonModel lesson) {
    setState(() {
      _draftLessons.removeWhere((l) => l.id == lesson.id);
      _publishedLessons.insert(0, lesson);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

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
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.addNewLessonScreen,
                      );
                    },
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
                child: selected == TeacherLessonsTab.published
                    ? PublishedTab(
                        lessons: _publishedLessons,
                        onEdit: _editLesson,
                        onDelete: (lesson) =>
                            _deleteLesson(lesson, isDraft: false),
                        onHomework: _openHomework,
                      )
                    : DraftTab(
                        drafts: _draftLessons,
                        onEdit: _editLesson,
                        onDelete: (lesson) =>
                            _deleteLesson(lesson, isDraft: true),
                        onPublish: _publishDraft,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
