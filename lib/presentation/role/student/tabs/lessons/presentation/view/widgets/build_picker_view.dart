import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class BuildPickerView extends StatelessWidget {
  const BuildPickerView({super.key, required this.isSubmitting, required this.hasFile, required this.isPdf, required this.fileName, this.pickedFile, required this.onTakePhoto, required this.onPickPdf, required this.submit});

  final bool isSubmitting;
  final bool hasFile;
  final bool isPdf;
  final String fileName;
  final File? pickedFile;
  final VoidCallback onTakePhoto;
  final VoidCallback onPickPdf;
  final VoidCallback submit;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasFile && !isPdf) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              pickedFile!,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
        ],

        if (hasFile && isPdf) ...[
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
                    text: fileName,
                    style: const TextStyle(color: Colors.green, fontSize: 12),
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
                onPressed: isSubmitting ? null : onTakePhoto,
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
                onPressed: isSubmitting ? null : onPickPdf,
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

        if (hasFile) ...[
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isSubmitting ? null : submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: isSubmitting
                  ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  :  Text(l10.submit),
            ),
          ),
        ],
      ],
    );
  }
}
