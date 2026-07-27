import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/homework_model.dart';
import '../../../../../../core/model/lesson_model.dart';
import '../../../../../../core/resources/colors/color_manger.dart';
import 'lesson_header_section.dart';
import 'lesson_materials_tab.dart';
import 'lesson_notes_tab.dart';
import 'lesson_overview_tab.dart';
import 'lesson_tab_selector.dart';
import 'lesson_video_player.dart';

class LessonDetails extends StatefulWidget {
  const LessonDetails({super.key, required this.lesson});

  final LessonModel lesson;

  @override
  State<LessonDetails> createState() => _LessonDetailsState();
}

class _LessonDetailsState extends State<LessonDetails> {
  LessonTab _selectedTab = LessonTab.overview;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LessonVideoPlayer(
                thumbnailUrl: widget.lesson.videoThumbnailUrl,
                videoUrl: widget.lesson.videoUrl,
                onBack: () => Navigator.pop(context),
              ),
              LessonHeaderSection(lesson: widget.lesson),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LessonTabSelector(
                  selected: _selectedTab,
                  onChanged: (tab) => setState(() => _selectedTab = tab),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: switch (_selectedTab) {
                  LessonTab.overview => LessonOverviewTab(
                    lesson: widget.lesson,
                    onHomeworkTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.homeWorkScreen,

                        arguments: DummyHomeworkData.all,
                      );
                    },
                  ),
                  LessonTab.materials => LessonMaterialsTab(
                    materials: widget.lesson.materials,
                  ),
                  LessonTab.notes => const LessonNotesTab(),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
