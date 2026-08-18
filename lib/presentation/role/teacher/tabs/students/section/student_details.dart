import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/model/student_detail_model.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../widgets/attendance_history_tab.dart';
import '../widgets/contact_info_card.dart';
import '../widgets/exam_result_tab.dart';
import '../widgets/lesson_progress_tab.dart';
import '../widgets/student_details_header.dart';
import '../widgets/student_details_tab_selector.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key, required this.student});

  final StudentDetailsModel student;

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  StudentDetailsTab _tab = StudentDetailsTab.progress;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Column(
          children: [
            StudentDetailsHeader(student: widget.student),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StudentDetailsTabSelector(
                      selected: _tab,
                      onChanged: (tab) => setState(() => _tab = tab),
                    ),
                    const SizedBox(height: 16),

                    if (_tab == StudentDetailsTab.progress) ...[
                      LessonProgressTab(
                        lessonProgress: widget.student.lessonProgress,
                      ),
                      ContactInfoCard(contactInfo: widget.student.contactInfo),
                    ] else if (_tab == StudentDetailsTab.exams)
                      ExamResultTab(examResults: widget.student.examResults)
                    else
                      AttendanceHistoryTab(
                        records: widget.student.attendanceRecords,
                      ),
                  ],
                ),
              ),
            ),

            if (_tab == StudentDetailsTab.progress)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.chat_bubble_outline,
                          size: 18,
                          color: Colors.white,
                        ),
                        label: Text(
                          l10.message,
                          style: const TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications_none,
                          size: 18,
                          color: ColorManager.black,
                        ),
                        label: Text(
                          l10.alertParent,
                          style: TextStyle(color: ColorManager.black),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(
                            color: ColorManager.gray.withValues(alpha: 0.3),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void alertParent(String phoneNumber) async {
    final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: ColorManager.red,
            content: Text(AppLocalizations.of(context)!.whatsappNotInstalled),
          ),
        );
      }
    }
  }
}
