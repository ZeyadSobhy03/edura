import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

enum StudentDetailsTab { progress, exams, attendance }

class StudentDetailsTabSelector extends StatelessWidget {
  const StudentDetailsTabSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final StudentDetailsTab selected;
  final ValueChanged<StudentDetailsTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final labels = {
      StudentDetailsTab.progress: localizeLabel(
        StudentDetailsTab.progress,
        l10,
      ),
      StudentDetailsTab.exams: localizeLabel(StudentDetailsTab.exams, l10),
      StudentDetailsTab.attendance: localizeLabel(
        StudentDetailsTab.attendance,
        l10,
      ),
    };

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: ColorManager.gray.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: StudentDetailsTab.values.map((tab) {
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
                  text: labels[tab]!,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : ColorManager.black.withValues(alpha: 0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String localizeLabel(StudentDetailsTab tab, AppLocalizations l10) {
    switch (tab) {
      case StudentDetailsTab.progress:
        return l10.progress;
      case StudentDetailsTab.exams:
        return l10.exams;
      case StudentDetailsTab.attendance:
        return l10.attendance;
    }
  }
}
