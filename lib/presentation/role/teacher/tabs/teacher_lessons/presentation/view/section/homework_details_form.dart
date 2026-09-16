import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/model/home_work/new_homework_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class HomeworkDetailsForm extends StatefulWidget {
  const HomeworkDetailsForm({
    super.key,
    required this.draft,
    required this.onNext,
  });

  final NewHomeworkModel draft;
  final VoidCallback onNext;

  @override
  State<HomeworkDetailsForm> createState() => _HomeworkDetailsFormState();
}

class _HomeworkDetailsFormState extends State<HomeworkDetailsForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _subjectController;
  late final TextEditingController _dueDateController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.draft.title);
    _descriptionController = TextEditingController(
      text: widget.draft.description,
    );
    _subjectController = TextEditingController(text: widget.draft.subject);
    _dueDateController = TextEditingController(
      text: widget.draft.dueDate != null
          ? DateFormat('dd/MM/yyyy').format(widget.draft.dueDate!)
          : '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _subjectController.dispose();
    _dueDateController.dispose();
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
      _descriptionController.text.trim().isNotEmpty &&
      _dueDateController.text.trim().isNotEmpty;

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final firstDate = now;
    final lastDate = DateTime(now.year + 1);

    final picked = await showDatePicker(
      context: context,
      initialDate: widget.draft.dueDate ?? now,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        widget.draft.dueDate = picked;
        _dueDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _handleNext() {
    if (!_canProceed) return;
    widget.draft
      ..title = _titleController.text.trim()
      ..description = _descriptionController.text.trim()
      ..subject = _subjectController.text.trim();
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel(l10.homeworkTitle ),
        CustomTextFormedField(
          controller: _titleController,
          onChanged: (_) => setState(() {}),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10.homeworkTitleRequired ;
            }
            return null;
          },
          hintText: l10.enterHomeworkTitle,
        ),
        const SizedBox(height: 20),
        _sectionLabel(l10.subject),
        CustomTextFormedField(
          onChanged: (_) => setState(() {}),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10.subjectRequired;
            }
            return null;
          },
          hintText: l10.subjectHint,
          controller: _subjectController,
        ),
        const SizedBox(height: 20),
        _sectionLabel(l10.description),
        CustomTextFormedField(
          onChanged: (_) => setState(() {}),
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
        _sectionLabel(l10.dueDate),
        CustomTextFormedField(
          controller: _dueDateController,
          readOnly: true,
          onTap: _selectDate,
          onChanged: (_) => setState(() {}),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10.dueDateRequired ;
            }
            return null;
          },
          hintText: l10.dueDateHint,
          suffix: const Icon(Icons.calendar_today),
        ),
        const SizedBox(height: 30),
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
              l10.nextAddAttachments,
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

