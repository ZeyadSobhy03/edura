import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../data/model/student_detail_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';




class LessonProgressTab extends StatelessWidget {
  const LessonProgressTab({super.key, required this.lessonProgress});

  final List<LessonProgress> lessonProgress;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: l10.lessonProgress,
            style: TextStyle(color: ColorManager.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          ...lessonProgress.map((lesson) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: lesson.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: ColorManager.black.withValues(alpha: 0.8),
                            fontSize: 13,
                          ),
                        ),
                      ),
                      CustomText(
                        text: '${lesson.progress}%',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: lesson.progress / 100,
                      minHeight: 5,
                      backgroundColor: ColorManager.gray.withValues(alpha: 0.12),
                      valueColor: const AlwaysStoppedAnimation(Colors.blue),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}