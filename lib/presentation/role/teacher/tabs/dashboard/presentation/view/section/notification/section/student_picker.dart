import 'package:edura/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../students/presentation/view_model/student/student_view_model.dart';

class StudentPicker extends StatelessWidget {
  const StudentPicker({
    super.key,
    required this.onDone,
    required this.selectedStudentIds,
    required this.selectedStudentNames,
    required this.onSelectionChanged,
  });

  final VoidCallback onDone;
  final List<String> selectedStudentIds;
  final List<String> selectedStudentNames;
  final void Function({
    required String id,
    required String name,
    required bool isSelected,
  })
  onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setSheetState) => SafeArea(

        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * .7,
          child: BlocBuilder<StudentCubit, StudentState>(
            builder: (context, state) {
              final l10 = AppLocalizations.of(context)!;
              if (state is StudentLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: ColorManager.primary),
                );
              }
              if (state is! StudentLoaded) {
                return Center(child: Text(l10.failedToLoadStudents));
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10.selectStudents,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CustomTextButton(text:  l10.done,onPressed: onDone,)

                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.students.length,
                      itemBuilder: (context, index) {
                        final student = state.students[index];
                        final selected = selectedStudentIds.contains(
                          student.id,
                        );
                        return CheckboxListTile(
                          value: selected,
                          title: Text(student.name),
                          onChanged: (isSelected) {
                            onSelectionChanged(
                              id: student.id,
                              name: student.name,
                              isSelected: isSelected ?? false,
                            );
                            setSheetState(() {});
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
