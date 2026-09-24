import 'dart:io';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../../../data/model/home_work/new_homework_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class HomeworkAttachmentUploadForm extends StatefulWidget {
  const HomeworkAttachmentUploadForm({
    super.key,
    required this.draft,
    required this.onPublish,
    required this.onSaveDraft,
    required this.isPublishing,
  });

  final NewHomeworkModel draft;
  final VoidCallback onPublish;
  final VoidCallback onSaveDraft;
  final bool isPublishing;

  @override
  State<HomeworkAttachmentUploadForm> createState() =>
      _HomeworkAttachmentUploadFormState();
}

class _HomeworkAttachmentUploadFormState
    extends State<HomeworkAttachmentUploadForm> {
  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.any,
      );

      if (result == null) return;

      final newFiles = result.files
          .where((file) => file.path != null)
          .map((file) => File(file.path!))
          .toList();

      setState(() {
        widget.draft.attachments = [
          ...widget.draft.attachments,
          ...newFiles,
        ];
      });
    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking files: $e'),
        ),
      );
    }
  }
  void _removeAttachment(int index) {
    setState(() {
      widget.draft.attachments.removeAt(index);
    });
  }

  String _getFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: l10.attachments,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: widget.isPublishing ? null : _pickFiles,
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorManager.primary.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  color: ColorManager.primary,
                  size: 50,
                ),
                const SizedBox(height: 12),
                CustomText(
                  text: l10.dragDropFiles,
                  style: TextStyle(
                    color: ColorManager.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                CustomText(
                  text: l10.supportedFormats,
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (widget.draft.attachments.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: l10.selectedFiles,
                style: TextStyle(
                  color: ColorManager.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              ...List.generate(widget.draft.attachments.length, (index) {
                final file = widget.draft.attachments[index];
                final fileName = file.path.split('/').last;
                final fileSize = _getFileSize(file.lengthSync());

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ColorManager.gray.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.attachment,
                          color: ColorManager.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: fileName,
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              CustomText(
                                text: fileSize,
                                style: TextStyle(
                                  color: ColorManager.black.withValues(
                                    alpha: 0.5,
                                  ),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: widget.isPublishing
                              ? null
                              : () => _removeAttachment(index),
                          icon: Icon(
                            Icons.close,
                            color: widget.isPublishing
                                ? Colors.grey
                                : ColorManager.red,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: widget.isPublishing ? null : widget.onSaveDraft,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.white,
                  disabledBackgroundColor: ColorManager.gray.withValues(
                    alpha: 0.3,
                  ),
                  side: BorderSide(color: ColorManager.primary),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l10.saveDraft,
                  style: TextStyle(
                    color: ColorManager.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: widget.isPublishing ? null : widget.onPublish,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  disabledBackgroundColor: ColorManager.gray.withValues(
                    alpha: 0.3,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  widget.isPublishing ? l10.publishing : l10.publish,
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
      ],
    );
  }
}
