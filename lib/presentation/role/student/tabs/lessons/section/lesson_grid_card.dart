import 'package:cached_network_image/cached_network_image.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/lesson_model.dart';
import '../../../../../../l10n/app_localizations.dart';

class LessonGridCard extends StatelessWidget {
  const LessonGridCard({super.key, required this.lesson, required this.onTap});

  final LessonModel lesson;
  final VoidCallback onTap;

  Color _subjectColor() {
    switch (lesson.subject.toLowerCase()) {
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
      onTap: onTap,
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
                    imageUrl: lesson.videoThumbnailUrl,
                    fit: BoxFit.cover,
                    errorWidget: (_, _, _) => Container(color: Colors.black12),
                  ),

                  if (lesson.isCompleted)
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
                            text: '${lesson.durationMinutes}  ${l10.min}',
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
                      text: lesson.subject,
                      style: TextStyle(
                        color: subjectColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  CustomText(
                    text: lesson.title,
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

                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: lesson.progress,
                      minHeight: 4,
                      backgroundColor: ColorManager.black.withValues(
                        alpha: 0.08,
                      ),
                      valueColor: AlwaysStoppedAnimation(subjectColor),
                    ),
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
