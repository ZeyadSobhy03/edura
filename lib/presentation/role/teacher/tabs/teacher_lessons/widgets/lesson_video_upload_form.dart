import 'dart:io';

import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/model/new_lesson_draft_model.dart';
import '../../../../../../l10n/app_localizations.dart';
import 'file_upload_dropzone.dart';

class LessonVideoUploadForm extends StatefulWidget {
  const LessonVideoUploadForm({
    super.key,
    required this.draft,
    required this.onNext,
  });

  final NewLessonDraftModel draft;
  final VoidCallback onNext;

  @override
  State<LessonVideoUploadForm> createState() => _LessonVideoUploadFormState();
}

class _LessonVideoUploadFormState extends State<LessonVideoUploadForm> {
  Future<void> _pickVideo() async {
    final result = await FilePicker.pickFiles(
      type: FileType.video,
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        widget.draft.videoFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final fileName = widget.draft.videoFile?.path.split('/').last;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FileUploadDropzone(
          icon: Icons.videocam,
          accentColor: ColorManager.primary,
          title: l10.uploadVideo,
          subtitle: l10.uploadVideoSubtitle,
          buttonLabel: l10.chooseFile,
          onPickFile: _pickVideo,
          selectedFileName: fileName,
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.orange.withValues(alpha: 0.25)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.access_time, color: Colors.orange, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: l10.processingTime,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    CustomText(
                      text: l10.processingTimeSubtitle,
                      style: TextStyle(
                        color: ColorManager.black.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.draft.videoFile != null ? widget.onNext : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              disabledBackgroundColor: ColorManager.gray.withValues(alpha: 0.3),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              l10.nextAddPdfs,
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