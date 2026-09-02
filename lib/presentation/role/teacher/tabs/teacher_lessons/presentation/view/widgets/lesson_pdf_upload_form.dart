import 'dart:io';

import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../data/model/new_lesson_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import 'file_upload_dropzone.dart';

class LessonPdfUploadForm extends StatefulWidget {
  const LessonPdfUploadForm({
    super.key,
    required this.draft,
    required this.onPublish,
    required this.onSaveDraft,
    required this.isPublishing,
  });

  final NewLessonModel draft;
  final VoidCallback onPublish;
  final VoidCallback onSaveDraft;
  final bool isPublishing;

  @override
  State<LessonPdfUploadForm> createState() => _LessonPdfUploadFormState();
}

class _LessonPdfUploadFormState extends State<LessonPdfUploadForm> {
  Future<void> _pickPdf() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        widget.draft.pdfFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final fileName = widget.draft.pdfFile?.path.split('/').last;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FileUploadDropzone(
          icon: Icons.description,
          accentColor: Colors.red,
          title: l10.uploadPdf,
          subtitle: l10.uploadPdfSubtitle,
          buttonLabel: l10.chooseFile,
          onPickFile: _pickPdf,
          selectedFileName: fileName,
        ),
        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.isPublishing ? null : widget.onPublish,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              disabledBackgroundColor: ColorManager.gray.withValues(alpha: 0.3),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: widget.isPublishing
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
            )
                : Text(
              l10.publishLesson,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: widget.isPublishing ? null : widget.onSaveDraft,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: ColorManager.gray.withValues(alpha: 0.08),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              l10.saveAsDraft,
              style: TextStyle(
                color: ColorManager.black,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}