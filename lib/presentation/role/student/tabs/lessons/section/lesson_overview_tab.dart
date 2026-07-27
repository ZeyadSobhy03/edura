import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/model/lesson_model.dart';
import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';
import 'teacher_notes_card.dart';

class LessonOverviewTab extends StatelessWidget {
  const LessonOverviewTab({
    super.key,
    required this.lesson,
    required this.onHomeworkTap,
  });

  final LessonModel lesson;
  final VoidCallback onHomeworkTap;

  Future<void> _downloadPdf() async {
    final uri = Uri.parse(lesson.pdfUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: lesson.overviewDescription,
          style: TextStyle(
            color: ColorManager.black.withValues(alpha: 0.75),
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        TeacherNotesCard(notes: lesson.teacherNotes),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _downloadPdf,
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
                onPressed: onHomeworkTap,
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
