import 'dart:developer';

import 'package:edura/core/model/file_viewer_arguments.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class SubmissionFileCard extends StatelessWidget {
  const SubmissionFileCard({
    super.key,
    required this.fileName,
    required this.fileUrl,
  });

  final String fileName;
  final String fileUrl;

  String get _ext => fileName.split('.').last.toLowerCase();

  bool get _isPdf => _ext == 'pdf';

  bool get _isImage => ['jpg', 'jpeg', 'png', 'webp', 'gif'].contains(_ext);

  Future<void> _download() async {
    final uri = Uri.parse(fileUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _openFull(BuildContext context) {
    Navigator.pushNamed(
      context,
      RouteManger.fileViewerScreen,
      arguments: FileViewerArguments(
        fileName: fileName,
        fileUrl: fileUrl,
        isPdf: _isPdf,
        isImage: _isImage,
      ),
    );
  }

  Widget _preview(BuildContext context, AppLocalizations l10) {
    log("fileUrl: $fileUrl, fileName: $fileName, isPdf: $_isPdf, isImage: $_isImage");
    if (_isPdf) {
      return IgnorePointer(
        child: SfPdfViewer.network(
          fileUrl,
          canShowScrollHead: false,
          canShowScrollStatus: false,
          enableDoubleTapZooming: false,
          pageLayoutMode: PdfPageLayoutMode.single,
        ),
      );
    }

    if (_isImage) {
      return Image.network(
        fileUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        loadingBuilder: (context, child, progress) => progress == null
            ? child
            : const Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              ),
        errorBuilder: (context, error, stack) =>
            const Center(child: Icon(Icons.broken_image_outlined, size: 40)),
      );
    }

    return Center(
      child: Icon(
        Icons.insert_drive_file_outlined,
        size: 40,
        color: ColorManager.black.withValues(alpha: 0.35),
      ),
    );
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
                Icon(
                  _isPdf
                      ? Icons.picture_as_pdf
                      : _isImage
                      ? Icons.image_outlined
                      : Icons.insert_drive_file_outlined,
                  color: _isPdf ? Colors.redAccent : ColorManager.primary,
                  size: 22,
                ),
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
                    style: const TextStyle(
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
          InkWell(
            onTap: () => _openFull(context),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(14),
              ),
              child: Container(
                width: double.infinity,
                height: 260,
                color: ColorManager.gray.withValues(alpha: 0.05),
                child: _preview(context, l10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
