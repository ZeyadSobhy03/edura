import 'dart:developer';

import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/presentation/view/widgets/subject_class_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/model/subject_class_model.dart';
import '../../../../../../../../../../../l10n/app_localizations.dart';
import '../../../section/add_edit_subject_sheet.dart';
import '../view_model/subject_classes_view_model.dart';

class SubjectsClassesScreen extends StatefulWidget {
  const SubjectsClassesScreen({super.key});

  @override
  State<SubjectsClassesScreen> createState() => _SubjectsClassesScreenState();
}

class _SubjectsClassesScreenState extends State<SubjectsClassesScreen> {
  String? get _teacherId => Supabase.instance.client.auth.currentUser?.id;

  @override
  void initState() {
    super.initState();
    final teacherId = _teacherId;
    if (teacherId != null) {
      context.read<SubjectClassesCubit>().fetchSubjects(teacherId: teacherId);
    }
  }

  Future<void> _openAddSheet() async {
    final teacherId = _teacherId;
    if (teacherId == null) return;

    final subject = await showModalBottomSheet<SubjectClassModel>(
      backgroundColor: ColorManager.white,

      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const AddEditSubjectSheet(),
    );

    log('Selected subject name: ${subject?.subjectName ?? 'No subject name'}');
    if (subject != null && mounted) {
      context.read<SubjectClassesCubit>().addSubject(
        teacherId: teacherId,
        subjectName: subject.subjectName,
      );
    }
  }

  Future<void> _openEditSheet(SubjectClassModel subject) async {
    final teacherId = _teacherId;
    if (teacherId == null) return;

    final result = await showModalBottomSheet<SubjectClassModel>(
      backgroundColor: ColorManager.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AddEditSubjectSheet(existing: subject),
    );

    if (result != null && mounted) {
      context.read<SubjectClassesCubit>().updateSubject(
        id: result.id,
        teacherId: teacherId,
        subjectName: result.subjectName,
      );
    }
  }

  void _confirmDelete(SubjectClassModel subject) {
    final teacherId = _teacherId;
    if (teacherId == null) return;
    final l10 = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: CustomText(
          text: l10.deleteGradeTitle(subject.subjectName),
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
              context.read<SubjectClassesCubit>().deleteSubject(
                id: subject.id,
                teacherId: teacherId,
              );
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
        centerTitle: true,
        title: CustomText(
          text: l10.mySubjectsAndClasses,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: ColorManager.primary),
            onPressed: _openAddSheet,
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<SubjectClassesCubit, SubjectClassesState>(
          builder: (context, state) {
            if (state is SubjectClassesLoading ||
                state is SubjectClassesInitial) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            }

            if (state is SubjectClassesError) {
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

            final subjects = (state as SubjectClassesLoaded).subjects;

            if (subjects.isEmpty) {
              return Center(
                child: CustomText(
                  text: l10.noSubjectsYet,
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.5),
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                return SubjectClassCard(
                  subject: subject,
                  onEdit: () => _openEditSheet(subject),
                  onDelete: () => _confirmDelete(subject),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
