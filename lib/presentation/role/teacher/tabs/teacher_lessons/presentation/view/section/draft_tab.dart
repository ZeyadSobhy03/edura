import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../widgets/lesson_card.dart';

class DraftTab extends StatelessWidget {
  const DraftTab({
    super.key,
    required this.drafts,
    required this.onEdit,
    required this.onDelete,
    required this.onPublish,
  });

  final List<LessonModel> drafts;
  final ValueChanged<LessonModel> onEdit;
  final ValueChanged<LessonModel> onDelete;
  final ValueChanged<LessonModel> onPublish;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    if (drafts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.drafts_outlined,
                  size: 40, color: ColorManager.gray.withValues(alpha: 0.4)),
              const SizedBox(height: 12),
              CustomText(
                text: l10.noDraftLessons,
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
      itemCount: drafts.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final lesson = drafts[index];
        return LessonCard(
          lesson: lesson,
          onEdit: () => onEdit(lesson),
          onDelete: () => onDelete(lesson),
          thirdActionLabel: l10.publish,
          thirdActionIcon: Icons.publish_outlined,
          thirdActionColor: Colors.green,
          onThirdAction: () => onPublish(lesson),
        );
      },
    );
  }
}