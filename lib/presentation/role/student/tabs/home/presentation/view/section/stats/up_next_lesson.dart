import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../core/model/lesson_model.dart';
import '../../../../../../../../../core/resources/routes/route_manger.dart';
import '../../../../../lessons/data/model/lesson_progress/lesson_progress.dart';
import '../../../../../lessons/presentation/view_model/lesson_progress/lesson_progress_view_model.dart';
import '../up_next_card.dart';

class UpNextLesson extends StatefulWidget {
  final LessonModel lesson;
  final String studentId;

  const UpNextLesson({
    super.key,
    required this.lesson,
    required this.studentId,
  });

  @override
  State<UpNextLesson> createState() => UpNextLessonState();
}

class UpNextLessonState extends State<UpNextLesson> {
  late Future<LessonProgressModel?> _progressFuture;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  void _loadProgress() {
    _progressFuture = context.read<LessonProgressCubit>().getProgress(
      widget.lesson.id,
      widget.studentId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LessonProgressModel?>(
      future: _progressFuture,
      builder: (context, snapshot) {
        final percent = snapshot.data?.progress ?? 0;
        final progress = (percent / 100).clamp(0.0, 1.0).toDouble();

        return UpNextCard(
          title: widget.lesson.title,
          duration: widget.lesson.durationMinutes,
          subject: widget.lesson.subject,
          progress: progress,
          onTap: () async {
            log('UpNextLesson: Navigating to lesson details for lesson ID: ${widget.lesson.id}');
            await Navigator.pushNamed(
              context,
              RouteManger.lessonDetails,
              arguments: widget.lesson,
            );
            if (mounted) setState(_loadProgress);
          },
        );
      },
    );
  }
}
