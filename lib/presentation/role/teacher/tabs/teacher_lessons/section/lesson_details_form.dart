import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/new_lesson_draft_model.dart';
import '../../../../../../l10n/app_localizations.dart';

class LessonDetailsForm extends StatefulWidget {
  const LessonDetailsForm({
    super.key,
    required this.draft,
    required this.onNext,
  });

  final NewLessonDraftModel draft;
  final VoidCallback onNext;

  @override
  State<LessonDetailsForm> createState() => _LessonDetailsFormState();
}

class _LessonDetailsFormState extends State<LessonDetailsForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _durationController;
  late final TextEditingController _descriptionController;

  static const _subjects = ['Mathematics', 'Physics', 'Chemistry', 'Biology'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.draft.title);
    _durationController = TextEditingController(text: widget.draft.duration);
    _descriptionController = TextEditingController(
      text: widget.draft.description,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: ColorManager.gray.withValues(alpha: 0.06),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
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
      _durationController.text.trim().isNotEmpty;

  void _handleNext() {
    if (!_canProceed) return;
    widget.draft
      ..title = _titleController.text.trim()
      ..duration = _durationController.text.trim()
      ..description = _descriptionController.text.trim();
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
          hintText: l10.lessonTitleHint,
        ),
        const SizedBox(height: 20),

        _sectionLabel(l10.duration),
        CustomTextFormedField(
          hintText: l10.durationHint,
          controller: _durationController,
          onChanged: (_) => setState(() {}),
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 20),

        _sectionLabel(l10.subject),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _subjects.map((subject) {
            final isSelected = widget.draft.subject == subject;
            return ChoiceChip(
              label: Text(subject),
              selected: isSelected,
              onSelected: (_) => setState(() => widget.draft.subject = subject),
              selectedColor: ColorManager.primary,
              backgroundColor: ColorManager.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : ColorManager.black,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? ColorManager.primary
                      : ColorManager.gray.withValues(alpha: 0.3),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        _sectionLabel(l10.description),
        CustomTextFormedField(
          hintText: l10.descriptionHint,
          onChanged: (_) => setState(() {}),
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,

          controller: _descriptionController,
          maxLines: 4,
        ),
        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: ColorManager.gray.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: l10.premiumContent,
                      style: TextStyle(
                        color: ColorManager.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomText(
                      text: l10.premiumContentSubtitle,
                      style: TextStyle(
                        color: ColorManager.black.withValues(alpha: 0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: widget.draft.isPremium,
                onChanged: (value) =>
                    setState(() => widget.draft.isPremium = value),
                activeThumbColor: ColorManager.primary,
              ),
            ],
          ),
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
