import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../l10n/app_localizations.dart';


class SubmissionFileCard extends StatelessWidget {
  const SubmissionFileCard({super.key, required this.fileName, required this.fileUrl});

  final String fileName;
  final String fileUrl;

  Future<void> _download() async {
    final uri = Uri.parse(fileUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                const Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomText(
                    text: fileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InkWell(
                  onTap: _download,
                  child: CustomText(
                    text: l10.download,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: ColorManager.gray.withValues(alpha: 0.12)),

          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: ColorManager.gray.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(14)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.description_outlined,
                    size: 40, color: ColorManager.black.withValues(alpha: 0.35)),
                const SizedBox(height: 8),
                CustomText(
                  text: l10.pdfPreview,
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.4),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}