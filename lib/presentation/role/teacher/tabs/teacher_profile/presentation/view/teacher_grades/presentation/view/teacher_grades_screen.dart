import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/presentation/view_model/grade_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../../../core/resources/routes/route_manger.dart';
import '../../../../../../../../../../l10n/app_localizations.dart';
import '../../data/model/grade_model.dart';
import 'widgets/grade_form_sheet.dart';
import 'widgets/grade_list_tile.dart';

class TeacherGradesScreen extends StatelessWidget {
  const TeacherGradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _TeacherGradesView();
  }
}

class _TeacherGradesView extends StatefulWidget {
  const _TeacherGradesView();

  @override
  State<_TeacherGradesView> createState() => _TeacherGradesViewState();
}

class _TeacherGradesViewState extends State<_TeacherGradesView> {
  String? teacherId;

  @override
  void initState() {
    super.initState();
    final currentUser = Supabase.instance.client.auth.currentUser;

    if (currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, RouteManger.loginRoute);
      });
      return;
    }

    teacherId = currentUser.id;
    context.read<GardeCubit>().fetchGrades(teacherId: teacherId);
  }

  void _openAddSheet(BuildContext context) {
    final cubit = context.read<GardeCubit>();
    showGradeFormSheet(
      context: context,

      onSubmit: (name, amount) {
        cubit.addGrade(
          teacherId: teacherId!,
          name: name,
          monthlyAmount: amount!,
        );
      },
    );
  }

  void _openEditSheet(BuildContext context, Grade grade) {
    final cubit = context.read<GardeCubit>();
    showGradeFormSheet(
      context: context,
      existing: grade,
      onSubmit: (name, amount) {
        cubit.updateGrade(
          id: grade.id,
          teacherId: teacherId!,
          name: name,
          monthlyAmount: amount!,
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, Grade grade) {
    final cubit = context.read<GardeCubit>();
    final l10 = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: CustomText(
          text: l10.deleteGradeTitle(grade.name),
          style: TextStyle(
            color: ColorManager.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: CustomText(
          text: l10.deleteGradeMessage,
          style: TextStyle(color: ColorManager.gray, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: CustomText(
              text: l10.cancel,
              style: TextStyle(color: ColorManager.gray),
            ),
          ),
          TextButton(
            onPressed: () {
              cubit.deleteGrade(id: grade.id, teacherId: teacherId!);
              Navigator.pop(dialogContext);
            },
            child: CustomText(
              text: l10.delete,
              style: TextStyle(color: ColorManager.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        title: CustomText(
          text: l10.grades,
          style: TextStyle(
            color: ColorManager.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primary,
        onPressed: () => _openAddSheet(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: BlocBuilder<GardeCubit, GradesState>(
          builder: (context, state) {
            if (state is GradesLoading || state is GradesInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorManager.primary,
                  strokeWidth: 2,
                ),
              );
            }

            if (state is GradesError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: CustomText(
                    text: state.message,
                    style: TextStyle(color: ColorManager.red),
                  ),
                ),
              );
            }

            final grades = (state as GradesLoaded).grades;

            if (grades.isEmpty) {
              return Center(
                child: CustomText(
                  text: l10.noGradesYet,
                  style: TextStyle(color: ColorManager.gray),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: grades.length,
              itemBuilder: (context, index) {
                final grade = grades[index];
                return GradeListTile(
                  grade: grade,
                  onEdit: () => _openEditSheet(context, grade),
                  onDelete: () => _confirmDelete(context, grade),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
