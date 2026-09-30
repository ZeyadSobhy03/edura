import 'package:edura/presentation/role/student/tabs/lessons/presentation/view_model/lesson_progress_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/model/lesson_model.dart';
import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';


class LessonHeaderSection extends StatefulWidget {
  const LessonHeaderSection({
    super.key,
    required this.lesson,
    required this.studentId,
  });

  final LessonModel lesson;
  final String studentId;

  @override
  State<LessonHeaderSection> createState() => _LessonHeaderSectionState();
}

class _LessonHeaderSectionState extends State<LessonHeaderSection> {
  @override
  void initState() {
    super.initState();
    context.read<LessonProgressCubit>().fetchLessonProgress(
      widget.lesson.id,
      widget.studentId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.purple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomText(
              text: widget.lesson.subject,
              style: const TextStyle(
                color: Colors.purple,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),

          CustomText(
            text: widget.lesson.title,
            style: TextStyle(
              color: ColorManager.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              CustomText(
                text: widget.lesson.teacherName,
                style: TextStyle(
                  color: ColorManager.black.withValues(alpha: 0.7),
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.access_time,
                size: 14,
                color: ColorManager.black.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 4),
              CustomText(
                text: '${widget.lesson.durationMinutes} ${l10.min}',
                style: TextStyle(
                  color: ColorManager.black.withValues(alpha: 0.5),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),


          const SizedBox(height: 6),
          BlocBuilder<LessonProgressCubit, LessonProgressState>(
            builder: (context, state) {
              double progress = widget.lesson.progress;
              Color progressColor = ColorManager.primary;

              if (state is LessonProgressLoaded) {
                progress = state.progress.progress.toDouble();
              } else if (state is LessonProgressFailure) {
                progressColor = ColorManager.red;
              }

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: l10.progress,
                        style: TextStyle(
                          color: ColorManager.black.withValues(alpha: 0.6),
                          fontSize: 13,
                        ),
                      ),
                      CustomText(
                        text: '$progress%',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  LinearProgressIndicator(
                    value: progress,
                    color: progressColor,
                    backgroundColor: ColorManager.gray.withValues(alpha: 0.2),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
