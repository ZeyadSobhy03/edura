import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view/widgets/lesson_grade_selector.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view/widgets/subject_selector.dart';
import 'package:flutter/material.dart';

import '../../../data/model/lessons/new_lesson_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class LessonDetailsForm extends StatefulWidget {
  const LessonDetailsForm({
    super.key,
    required this.draft,
    required this.onNext,
  });

  final NewLessonModel draft;
  final VoidCallback onNext;

  @override
  State<LessonDetailsForm> createState() => _LessonDetailsFormState();
}

class _LessonDetailsFormState extends State<LessonDetailsForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _durationController;
  late final TextEditingController _descriptionController;
  String? _selectedGradeId;
  String? _selectedGradeName;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.draft.title);
    _durationController = TextEditingController(
      text: widget.draft.durationMinutes.toString(),
    );
    _descriptionController = TextEditingController(
      text: widget.draft.description,
    );
    _selectedGradeId = widget.draft.gradeId;
    _selectedGradeName = widget.draft.grade;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: CustomText(
        text: text,
        style: TextStyle(
          color: ColorManager.black.withValues(alpha: 0.5),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  bool get _canProceed =>
      _titleController.text.trim().isNotEmpty &&
      _durationController.text.trim().isNotEmpty &&
      _selectedGradeId != null &&
      _selectedGradeName != null;

  void _handleNext() {
    if (!_canProceed) return;
    widget.draft
      ..title = _titleController.text.trim()
      ..durationMinutes = int.parse(_durationController.text.trim())
      ..description = _descriptionController.text.trim()
      ..gradeId = _selectedGradeId!
      ..grade = _selectedGradeName!;
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel(l10.lessonTitle),
        CustomTextFormedField(
          controller: _titleController,
          onChanged: (_) => setState(() {}),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10.lessonTitleRequired;
            }
            return null;
          },
          hintText: l10.lessonTitleHint,
        ),
        const SizedBox(height: 20),

        _sectionLabel(l10.duration),
        CustomTextFormedField(
          onChanged: (_) => setState(() {}),

          hintText: l10.durationHint,
          controller: _durationController,

          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10.durationRequired;
            }
            final duration = int.tryParse(value);
            if (duration == null || duration <= 0) {
              return l10.durationInvalid;
            }
            return null;
          },
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),

        _sectionLabel(l10.subject),
        SubjectSelector(
          onChanged: (subject) => setState(() {
            widget.draft.subject = subject;
          }),
          selectedSubject: widget.draft.subject,
        ),

        const SizedBox(height: 20),

        _sectionLabel(l10.description),
        CustomTextFormedField(
          onChanged: (_) => setState(() {}),
          minLines: 4,

          hintText: l10.descriptionHint,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10.descriptionRequired;
            }
            return null;
          },
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,

          controller: _descriptionController,
          maxLines: 4,
        ),
        const SizedBox(height: 20),

        _sectionLabel(l10.grade),
        LessonGradeSelector(
          selectedGradeId: _selectedGradeId,
          onChanged: (grade) => setState(() {
            _selectedGradeId = grade.id;
            _selectedGradeName = grade.name;
          }),
        ),
        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _canProceed ? _handleNext : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              disabledBackgroundColor: ColorManager.gray.withValues(alpha: 0.3),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              l10.nextUploadVideo,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
