import 'package:flutter/material.dart';

import '../../../../../../core/model/lesson_model.dart';
import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class LessonHeaderSection extends StatelessWidget {
  const LessonHeaderSection({super.key, required this.lesson});

  final LessonModel lesson;

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
              text: lesson.subject,
              style: const TextStyle(
                color: Colors.purple,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Title
          CustomText(
            text: lesson.title,
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
                text: lesson.teacherName,
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
                text: '${lesson.durationMinutes} ${l10.min}',
                style: TextStyle(
                  color: ColorManager.black.withValues(alpha: 0.5),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

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
                text: '${(lesson.progress * 100).round()}%',
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: lesson.progress,
              minHeight: 6,
              backgroundColor: ColorManager.black.withValues(alpha: 0.08),
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
