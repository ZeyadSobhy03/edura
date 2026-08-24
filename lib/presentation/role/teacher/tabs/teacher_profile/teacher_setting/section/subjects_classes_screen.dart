import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/teacher_setting/section/subject_class_card.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/model/subject_class_model.dart';
import '../../../../../../../l10n/app_localizations.dart';
import 'add_edit_subject_sheet.dart';


class SubjectsClassesScreen extends StatefulWidget {
  const SubjectsClassesScreen({super.key});

  @override
  State<SubjectsClassesScreen> createState() => _SubjectsClassesScreenState();
}

class _SubjectsClassesScreenState extends State<SubjectsClassesScreen> {
  // TODO: replace with real Supabase-fetched subjects for this teacher
  final List<SubjectClassModel> _subjects = [
    SubjectClassModel(id: '1', subjectName: 'Mathematics', studentsCount: 85, activeClasses: 3),
    SubjectClassModel(id: '2', subjectName: 'Physics', studentsCount: 35, activeClasses: 2),
  ];

  Future<void> _openAddSheet() async {
    final result = await showModalBottomSheet<SubjectClassModel>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const AddEditSubjectSheet(),
    );
    if (result != null) {
      setState(() => _subjects.add(result));
    }
  }

  Future<void> _openEditSheet(SubjectClassModel subject) async {
    final result = await showModalBottomSheet<SubjectClassModel>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AddEditSubjectSheet(existing: subject),
    );
    if (result != null) {
      setState(() {
        final index = _subjects.indexWhere((s) => s.id == result.id);
        if (index >= 0) _subjects[index] = result;
      });
    }
  }

  void _deleteSubject(SubjectClassModel subject) {
    setState(() => _subjects.removeWhere((s) => s.id == subject.id));
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
          style: TextStyle(color: ColorManager.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: ColorManager.primary),
            onPressed: _openAddSheet,
          ),
        ],
      ),
      body: SafeArea(
        child: _subjects.isEmpty
            ? Center(
          child: CustomText(
            text: l10.noSubjectsYet,
            style: TextStyle(color: ColorManager.black.withValues(alpha: 0.5)),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _subjects.length,
          itemBuilder: (context, index) {
            final subject = _subjects[index];
            return SubjectClassCard(
              subject: subject,
              onEdit: () => _openEditSheet(subject),
              onDelete: () => _deleteSubject(subject),
            );
          },
        ),
      ),
    );
  }
}