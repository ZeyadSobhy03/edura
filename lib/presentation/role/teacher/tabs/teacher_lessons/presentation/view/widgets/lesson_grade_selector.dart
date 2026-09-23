
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/data/model/grade_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../teacher_profile/presentation/view/teacher_grades/presentation/view_model/grade_view_model.dart';

class LessonGradeSelector extends StatefulWidget {
  const LessonGradeSelector({
    super.key,
    required this.selectedGradeId,
    required this.onChanged,
  });

  final String? selectedGradeId;
  final ValueChanged<Grade> onChanged;

  @override
  State<LessonGradeSelector> createState() => _LessonGradeSelectorState();
}

class _LessonGradeSelectorState extends State<LessonGradeSelector> {
  @override
  void initState() {
    super.initState();
    final teacherId = Supabase.instance.client.auth.currentUser?.id;
    if (teacherId != null) {
      context.read<GardeCubit>().fetchGrades(teacherId: teacherId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return BlocBuilder<GardeCubit, GradesState>(
      builder: (context, state) {
        if (state is GradesLoading || state is GradesInitial) {
          return const Center(child: CircularProgressIndicator(
            color : ColorManager.primary,
          ));
        }

        if (state is GradesError) {
          return CustomText(
            text: state.message,
            style: TextStyle(color: ColorManager.red),
          );
        }

        final grades = (state as GradesLoaded).grades;

        if (grades.isEmpty) {
          return CustomText(
            text: l10.noGradesFound,
            style: TextStyle(color: ColorManager.gray),
          );
        }

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: grades.map((grade) {
            final isSelected = grade.id == widget.selectedGradeId;
            return _GradeChip(
              label: grade.name,
              isSelected: isSelected,
              onTap: () => widget.onChanged(grade),
            );
          }).toList(),
        );
      },
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
