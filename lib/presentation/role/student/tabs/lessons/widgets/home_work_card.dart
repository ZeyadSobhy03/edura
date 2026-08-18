import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/model/homework_model.dart';
import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/localization/status_localization.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class HomeWorkCard extends StatefulWidget {
  const HomeWorkCard({super.key, this.homework});

  final HomeworkModel? homework;

  @override
  State<HomeWorkCard> createState() => _HomeWorkCardState();
}

class _HomeWorkCardState extends State<HomeWorkCard> {
  final ImagePicker _imagePicker = ImagePicker();

  File? _selectedImage;
  PlatformFile? _selectedPdf;

  Future<void> _takePhoto() async {
    final photo = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (photo != null) {
      setState(() {
        _selectedImage = File(photo.path);
      });
    }
  }

  Future<void> _pickPdf() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedPdf = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final homework = widget.homework;

    return Card(
      elevation: 0,
      color: ColorManager.black.withValues(alpha: 0.03),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorManager.black.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomText(
                    text: homework?.title ?? '',
                    style: TextStyle(
                      color: ColorManager.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomText(
                    text: StatusLocalization.getStatusText(
                      homework?.status ?? HomeworkStatus.pending,
                      l10,
                    ),
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: CustomText(
                text: homework?.subject ?? ' ',
                style: const TextStyle(color: Colors.blue, fontSize: 11),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: ColorManager.black.withValues(alpha: 0.5),
                ),
                const SizedBox(width: 6),
                CustomText(
                  text: "${homework?.dueDate ?? ''}",
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.6),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Show selected image preview
            if (_selectedImage != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _selectedImage!,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
            ],

            // Show selected PDF name
            if (_selectedPdf != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.picture_as_pdf, color: Colors.green, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomText(
                        text: _selectedPdf!.name,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _takePhoto,
                    icon: const Icon(Icons.camera_alt_outlined, size: 18),
                    label: Text(
                      l10.takePhoto,
                      style: TextStyle(color: ColorManager.primary),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: ColorManager.primary.withValues(alpha: 0.1),
                      foregroundColor: ColorManager.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: ColorManager.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickPdf,
                    icon: const Icon(
                      Icons.upload_file,
                      size: 18,
                      color: Colors.green,
                    ),
                    label: Text(
                      l10.attachPdf,
                      style: const TextStyle(color: Colors.green),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}