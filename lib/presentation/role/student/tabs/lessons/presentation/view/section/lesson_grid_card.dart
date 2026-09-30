import 'package:cached_network_image/cached_network_image.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/model/lesson_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/lesson_progress_view_model.dart';


class LessonGridCard extends StatefulWidget {
  const LessonGridCard({super.key, required this.lesson, required this.onTap});

  final LessonModel lesson;
  final VoidCallback onTap;

  @override
  State<LessonGridCard> createState() => _LessonGridCardState();
}

class _LessonGridCardState extends State<LessonGridCard> {
  String? studentId;

  @override
  void initState() {
    super.initState();

    studentId = Supabase.instance.client.auth.currentUser?.id;

    if (studentId != null) {
      context.read<LessonProgressCubit>().fetchLessonProgress(
        widget.lesson.id,
        studentId!,
      );
    }
  }

  Color _subjectColor() {
    switch (widget.lesson.subject.toLowerCase()) {
      case 'mathematics':
        return Colors.blue;

      case 'physics':
        return Colors.purple;

      default:
        return ColorManager.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final subjectColor = _subjectColor();
    final l10 = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 11,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.lesson.videoThumbnailUrl,
                    fit: BoxFit.cover,
                    errorWidget: (_, _, _) {
                      return Container(color: Colors.black12);
                    },
                  ),

                  if (widget.lesson.isCompleted)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 10,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 3),
                          CustomText(
                            text: '${widget.lesson.durationMinutes} ${l10.min}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: subjectColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: CustomText(
                      text: widget.lesson.subject,
                      style: TextStyle(
                        color: subjectColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  CustomText(
                    text: widget.lesson.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 6),

                  BlocBuilder<LessonProgressCubit, LessonProgressState>(
                    builder: (context, state) {
                      final cubit = context.read<LessonProgressCubit>();

                      final savedProgress = cubit.progressMap[widget.lesson.id];

                      double progress =
                          savedProgress?.progress.toDouble() ??
                          widget.lesson.progress;

                      Color progressColor = ColorManager.primary;

                      if (state is LessonProgressLoading &&
                          state.lessonId == widget.lesson.id) {}

                      if (state is LessonProgressLoaded &&
                          state.lessonId == widget.lesson.id) {
                        progress = state.progress.progress.toDouble();
                      }

                      if (state is LessonProgressFailure &&
                          state.lessonId == widget.lesson.id) {
                        progressColor = ColorManager.red;
                      }

                      if (state is LessonProgressNotFound &&
                          state.lessonId == widget.lesson.id) {
                        progress = widget.lesson.progress;
                      }

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress.clamp(0.0, 1.0),
                          minHeight: 5,
                          color: progressColor,
                          backgroundColor: ColorManager.gray.withValues(
                            alpha: 0.2,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
