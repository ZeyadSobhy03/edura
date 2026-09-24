import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_label.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/core/widgets/grade_chip.dart';
import 'package:edura/presentation/role/teacher/tabs/students/presentation/view/section/student_card.dart';
import 'package:edura/presentation/role/teacher/tabs/students/presentation/view_model/student/student_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../l10n/app_localizations.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  late final TextEditingController _searchController;
  String _searchQuery = '';
  String? _selectedGrade;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<StudentCubit>().getStudents();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: BlocBuilder<StudentCubit, StudentState>(
        builder: (context, state) {
          if (state is StudentLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorManager.primary,
                strokeWidth: 2,
              ),
            );
          }

          if (state is StudentLoaded) {
            if (state.students.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: CustomText(
                    text: l10.noStudentsFound,
                    style: TextStyle(
                      color: ColorManager.black.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              );
            }

            final grades = state.students.map((s) => s.grade).toSet().toList()
              ..sort();

            final students = state.students.where((student) {
              final matchesSearch =
              student.name.toLowerCase().contains(_searchQuery);
              final matchesGrade =
                  _selectedGrade == null || student.grade == _selectedGrade;
              return matchesSearch && matchesGrade;
            }).toList();

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomLabel(label: l10.students, fontSize: 20),
                    const SizedBox(height: 8),
                    CustomTextFormedField(
                      controller: _searchController,
                      hintText: l10.searchStudents,
                      prefix: Icon(Icons.search, color: ColorManager.gray),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value.toLowerCase().trim();
                        });
                      },
                    ),
                    const SizedBox(height: 12),

                    SizedBox(
                      height: 36,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          GradeChip(
                            label: l10.all,
                            selected: _selectedGrade == null,
                            onTap: () => setState(() => _selectedGrade = null),
                          ),
                          const SizedBox(width: 8),
                          ...grades.map(
                                (grade) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GradeChip(
                                label: grade,
                                selected: _selectedGrade == grade,
                                onTap: () =>
                                    setState(() => _selectedGrade = grade),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        return StudentCard(
                          student: students[index],
                          onTap: () async {
                            final studentCubit = context.read<StudentCubit>();

                            await Navigator.pushNamed(
                              context,
                              RouteManger.studentDetailsScreen,
                              arguments: students[index],
                            );

                            if (!mounted) return;
                            studentCubit.getStudents();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: CustomText(
                text: l10.errorOccurred,
                style: TextStyle(color: ColorManager.red),
              ),
            ),
          );
        },
      ),
    );
  }
}

