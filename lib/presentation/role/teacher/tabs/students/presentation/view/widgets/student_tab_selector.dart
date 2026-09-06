import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';


enum StudentTab { all, active, inactive, blocked }

class StudentTabSelector extends StatefulWidget {
  const StudentTabSelector({
    super.key,
    required this.currentTab,
    required this.onStepTapped,
  });

  final StudentTab currentTab;
  final ValueChanged<StudentTab> onStepTapped;

  @override
  State<StudentTabSelector> createState() => _StudentTabSelectorState();
}

class _StudentTabSelectorState extends State<StudentTabSelector> {
  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Row(
      children: [
        _tab(StudentTab.all, localizeLabel(StudentTab.all, l10)),
        const SizedBox(width: 8),
        _tab(StudentTab.active, localizeLabel(StudentTab.active, l10)),
        const SizedBox(width: 8),
        _tab(StudentTab.inactive, localizeLabel(StudentTab.inactive, l10)),
        const SizedBox(width: 8),
        _tab(StudentTab.blocked, localizeLabel(StudentTab.blocked, l10)),
      ],
    );
  }

  Widget _tab(StudentTab step, String label) {
    final isSelected = step == widget.currentTab;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onStepTapped(step);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? ColorManager.primary
                : ColorManager.gray.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomText(
            text: label,
            style: TextStyle(
              color: isSelected
                  ? ColorManager.white
                  : ColorManager.black.withValues(alpha: 0.7),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  String localizeLabel(StudentTab step, AppLocalizations l10) {
    switch (step) {
      case StudentTab.all:
        return l10.all;
      case StudentTab.active:
        return l10.active;
      case StudentTab.inactive:
        return l10.inactive;
      case StudentTab.blocked:
        return l10.blocked;
    }
  }
}
