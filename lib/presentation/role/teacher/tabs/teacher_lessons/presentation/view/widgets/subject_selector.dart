import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/presentation/view_model/subject_classes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/widgets/custom_chip.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class SubjectSelector extends StatefulWidget {
  const SubjectSelector({
    super.key,
    this.selectedSubject,
    required this.onChanged,
  });

  final String? selectedSubject;

  final ValueChanged<String> onChanged;

  @override
  State<SubjectSelector> createState() => _SubjectSelectorState();
}

class _SubjectSelectorState extends State<SubjectSelector> {
  @override
  void initState() {
    super.initState();
    final teacherId = Supabase.instance.client.auth.currentUser?.id;
    if (teacherId != null) {
      context.read<SubjectClassesCubit>().fetchSubjects(teacherId: teacherId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return BlocBuilder<SubjectClassesCubit, SubjectClassesState>(
      builder: (context, state) {
        if (state is SubjectClassesLoading || state is SubjectClassesInitial) {
          return const Center(
            child: CircularProgressIndicator(color: ColorManager.primary),
          );
        }
        if (state is SubjectClassesError) {
          return CustomText(
            text: state.message,
            style: TextStyle(color: ColorManager.red),
          );
        }
        final subjects = (state as SubjectClassesLoaded).subjects;
        if (subjects.isEmpty) {
          return CustomText(
            text: l10.noSubjectsFound,
            style: TextStyle(color: ColorManager.gray),
          );
        } else {
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: subjects.map((subject) {
              final isSelected = widget.selectedSubject == subject.subjectName;
              return CustomChip(
                label: subject.subjectName,
                isSelected: isSelected,
                onTap: () => widget.onChanged(subject.subjectName),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
