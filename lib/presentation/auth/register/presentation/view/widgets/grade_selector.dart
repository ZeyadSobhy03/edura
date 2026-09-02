import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

class GradeSelector extends StatelessWidget {
  const GradeSelector({
    super.key,
    required this.grades,
    required this.selectedGrade,
    required this.onChanged,
  });

  final List<String> grades;
  final String? selectedGrade;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: grades.map((grade) {
        final isSelected = grade == selectedGrade;
        return _GradeChip(
          label: grade,
          isSelected: isSelected,
          onTap: () => onChanged(grade),
        );
      }).toList(),
    );
  }
}

class _GradeChip extends StatelessWidget {
  const _GradeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? ColorManager.primary.withValues(alpha: .08)
                : ColorManager.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? ColorManager.primary
                  : ColorManager.gray.withValues(alpha: .4),
              width: 1.2,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? ColorManager.primary : ColorManager.black,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}