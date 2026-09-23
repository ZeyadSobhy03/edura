import 'dart:io';

import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/home_work/new_homework_model.dart';

class LessonHomeworkUploadForm extends StatefulWidget {
  const LessonHomeworkUploadForm({
    super.key,
    required this.onNext,
    required this.onSkip,
    required this.isSubmitting,
  });

  final ValueChanged<NewHomeworkModel> onNext;

  final VoidCallback onSkip;

  final bool isSubmitting;

  @override
  State<LessonHomeworkUploadForm> createState() =>
      _LessonHomeworkUploadFormState();
}

class _LessonHomeworkUploadFormState extends State<LessonHomeworkUploadForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _subject = 'Mathematics';
  DateTime? _dueDate;
  final List<File> _attachments = [];

  static const _subjects = [
    'Mathematics',
    'Science',
    'English',
    'History',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickAttachments() async {
    final result = await FilePicker.pickFiles(type: FileType.any);
    if (result == null) return;

    setState(() {
      _attachments.addAll(
        result.paths.whereType<String>().map((path) => File(path)),
      );
    });
  }

  void _removeAttachment(int index) {
    setState(() => _attachments.removeAt(index));
  }

  Future<void> _pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorManager.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorManager.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDate: _dueDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final homework = NewHomeworkModel(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      subject: _subject,
      dueDate: _dueDate,
      isPublished: true,
      attachments: _attachments,
    );

    widget.onNext(homework);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: l10.homework,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          CustomTextFormedField(
            minLines: 1,
            hintText: l10.enterHomeworkTitle,

            controller: _titleController,

            validator: (value) => (value == null || value.trim().isEmpty)
                ? l10.requiredField
                : null,
          ),
          const SizedBox(height: 12),

          CustomTextFormedField(
            controller: _descriptionController,
            minLines: 4,

            hintText: l10.enterHomeworkDescription,
            validator: (value) => (value == null || value.trim().isEmpty)
                ? l10.requiredField
                : null,
          ),
          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
            dropdownColor: ColorManager.white,
            initialValue: _subject,
            items: _subjects
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _subject = value);
            },
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: _pickDueDate,
            child: InputDecorator(
              decoration: InputDecoration(labelText: l10.dueDate),
              child: Text(
                _dueDate == null
                    ? l10.selectDate
                    : '${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}',
              ),
            ),
          ),
          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: _pickAttachments,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: ColorManager.primary),
            ),
            icon:  Icon(Icons.attach_file,color: ColorManager.primary,),
            label: Text(
              l10.addAttachment,
              style: TextStyle(color: ColorManager.primary,

              ),
            ),
          ),
          const SizedBox(height: 8),

          ..._attachments.asMap().entries.map(
            (entry) => ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.insert_drive_file),
              title: Text(
                entry.value.path.split(Platform.pathSeparator).last,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: widget.isSubmitting
                    ? null
                    : () => _removeAttachment(entry.key),
              ),
            ),
          ),

          const SizedBox(height: 24),
/*
 onPressed: widget.isSubmitting ? null : widget.onSkip,
                  child: Text(l10.skipAndPublish),
 */
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: ColorManager.primary),
                  ),
                  onPressed: widget.isSubmitting ? null : widget.onSkip,
                  child: Text(l10.skipAndPublish, style: TextStyle(color: ColorManager.primary)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    side: BorderSide(color: ColorManager.primary)
                  ),
                  onPressed: widget.isSubmitting ? null : _submit,
                  child: widget.isSubmitting
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(l10.addHomeworkAndPublish, style: const TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
