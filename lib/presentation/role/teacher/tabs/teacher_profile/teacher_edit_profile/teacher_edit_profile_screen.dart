import 'package:edura/core/extensions/text_ex.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/teacher_edit_profile/section/teacher_edit_profile_body.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/teacher_profile_model.dart';
import '../../../../../../l10n/app_localizations.dart';

class TeacherEditProfileScreen extends StatefulWidget {
  const TeacherEditProfileScreen({super.key, required this.teacher});

  final TeacherProfileModel teacher;

  @override
  State<TeacherEditProfileScreen> createState() =>
      _TeacherEditProfileScreenState();
}

class _TeacherEditProfileScreenState extends State<TeacherEditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _subjectController;
  late final TextEditingController _yearsController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.teacher.name);
    _subjectController = TextEditingController(text: widget.teacher.subject);
    _yearsController = TextEditingController(
      text: '${widget.teacher.yearsExperience}',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _subjectController.dispose();
    _yearsController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10 = AppLocalizations.of(context)!;

    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10.nameRequired)));
      return;
    }
    if (_subjectController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10.subjectRequired)));
      return;
    }

    setState(() => _isSaving = true);

    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;
    setState(() => _isSaving = false);

    final updated = TeacherProfileModel(
      name: _nameController.text.trim(),
      subject: _subjectController.text.trim(),
      avatarUrl: "",
      studentsCount: widget.teacher.studentsCount,

      rating: widget.teacher.rating,
      yearsExperience:
          int.tryParse(_yearsController.text.trim()) ??
          widget.teacher.yearsExperience,
    );

    Navigator.pop(context, updated);
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
          text: l10.editProfile,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 44,
                  backgroundColor: ColorManager.primary.withValues(alpha: 0.1),
                  child: CustomText(
                    text: _nameController.text.initials,
                    style: TextStyle(
                      color: ColorManager.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              TeacherEditProfileBody(
                nameController: _nameController,
                subjectController: _subjectController,
                yearsController: _yearsController,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          l10.save,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
