import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/custom_text.dart';

enum LessonTab { overview, materials, notes }

class LessonTabSelector extends StatelessWidget {
  const LessonTabSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final LessonTab selected;
  final ValueChanged<LessonTab> onChanged;

  static const _labels = {
    LessonTab.overview: 'Overview',
    LessonTab.materials: 'Materials',
    LessonTab.notes: 'Notes',
  };

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: LessonTab.values.map((tab) {
          final isSelected = tab == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(tab),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: CustomText(
                  text: localizeLabel(_labels[tab]!, localizations),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String localizeLabel(String label, AppLocalizations localizations) {
    switch (label) {
      case 'Overview':
        return localizations.overview;
      case 'Materials':
        return localizations.materials;
      case 'Notes':
        return localizations.notes;
      default:
        return label;
    }
  }
}
