import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../widgets/lesson_card.dart';

class PublishedTab extends StatelessWidget {
  const PublishedTab({
    super.key,
    required this.lessons,
    required this.onEdit,
    required this.onDelete,
    required this.onHomework,
  });

  final List<LessonModel> lessons;
  final ValueChanged<LessonModel> onEdit;
  final ValueChanged<LessonModel> onDelete;
  final ValueChanged<LessonModel> onHomework;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    if (lessons.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.menu_book_outlined,
                  size: 40, color: ColorManager.gray.withValues(alpha: 0.4)),
              const SizedBox(height: 12),
              CustomText(
                text: l10.noPublishedLessons,
                style: TextStyle(
                  color: ColorManager.black.withValues(alpha: 0.5),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: lessons.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        return LessonCard(
          lesson: lesson,

          onEdit: () => onEdit(lesson),
          onDelete: () => onDelete(lesson),
          thirdActionLabel: l10.homework,
          thirdActionIcon: Icons.assignment_outlined,
          onThirdAction: () => onHomework(lesson),
        );
      },
    );
  }
}