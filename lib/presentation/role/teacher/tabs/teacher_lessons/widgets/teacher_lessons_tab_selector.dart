import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

enum TeacherLessonsTab { published, draft }

class TeacherLessonsTabSelector extends StatelessWidget {
  const TeacherLessonsTabSelector({
    super.key,
    required this.selected,
    required this.onTabSelected,
  });

  final TeacherLessonsTab selected;
  final ValueChanged<TeacherLessonsTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: ColorManager.gray.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _tab(
            label: l10.published,
            isSelected: selected == TeacherLessonsTab.published,
            onTap: () => onTabSelected(TeacherLessonsTab.published),
          ),
          _tab(
            label: l10.draft,
            isSelected: selected == TeacherLessonsTab.draft,
            onTap: () => onTabSelected(TeacherLessonsTab.draft),
          ),
        ],
      ),
    );
  }

  Widget _tab({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? ColorManager.white : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 4,
                    ),
                  ]
                : null,
          ),
          child: CustomText(
            text: label,
            style: TextStyle(
              color: isSelected
                  ? ColorManager.primary
                  : ColorManager.black.withValues(alpha: 0.5),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
