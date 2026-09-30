import 'package:edura/core/helper/file_downloader.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../../../core/model/lesson_model.dart';
import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import 'teacher_notes_card.dart';

class LessonOverviewTab extends StatefulWidget {
  const LessonOverviewTab({
    super.key,
    required this.lesson,
    required this.onHomeworkTap,
  });

  final LessonModel lesson;
  final VoidCallback onHomeworkTap;

  @override
  State<LessonOverviewTab> createState() => _LessonOverviewTabState();
}

class _LessonOverviewTabState extends State<LessonOverviewTab> {
  double downloadProgress = 0.0;
  bool isDownloading = false;

  Future<void> _downloadPdf() async {
    setState(() {
      isDownloading = true;
      downloadProgress = 0.0;
    });

    try {
      final url = widget.lesson.pdfUrl;
      final fileName = '${widget.lesson.title}.pdf';

      await FileDownloader.downloadFile(url, fileName, (progress) {
        if (!mounted) return;

        setState(() {
          downloadProgress = progress;
        });
      });

      if (!mounted) return;
      Fluttertoast.showToast(
        msg:
            "${AppLocalizations.of(context)!.successfullyDownload} ${widget.lesson.title}.pdf",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorManager.green,
        textColor: ColorManager.white,
      );
    } catch (e) {
      if (!mounted) return;

      Fluttertoast.showToast(
        msg:
            "${AppLocalizations.of(context)!.downloadFailed} ${widget.lesson.title}.pdf",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() {
        isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: widget.lesson.title,
          style: TextStyle(
            color: ColorManager.black.withValues(alpha: 0.75),
            fontSize: 14,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 16),

        TeacherNotesCard(notes: widget.lesson.overviewDescription),

        const SizedBox(height: 16),

        if (isDownloading) ...[
          LinearProgressIndicator(
            trackGap: 0,
            minHeight: 4,

            value: downloadProgress,
            color: ColorManager.primary,
            backgroundColor: ColorManager.white,
          ),

          const SizedBox(height: 8),

          Text(
            '${(downloadProgress * 100).toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 12),
          ),

          const SizedBox(height: 12),
        ],

        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: isDownloading ? null : _downloadPdf,
                icon: const Icon(Icons.download, size: 18),
                label: Text(l10.downloadPdf),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  foregroundColor: ColorManager.black,
                  side: BorderSide(
                    color: ColorManager.black.withValues(alpha: 0.2),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: ElevatedButton.icon(
                onPressed: widget.onHomeworkTap,
                icon: const Icon(
                  Icons.assignment,
                  size: 18,
                  color: Colors.white,
                ),
                label: Text(
                  l10.homework,
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
