import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/homework_submission_model.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../widgets/grade_input_field.dart';
import '../widgets/submission_file_card.dart';
import '../widgets/submission_student_header.dart';

class ReviewHomeworkScreen extends StatefulWidget {
  const ReviewHomeworkScreen({super.key, required this.submission});

  final HomeworkSubmissionModel submission;

  @override
  State<ReviewHomeworkScreen> createState() => _ReviewHomeworkScreenState();
}

class _ReviewHomeworkScreenState extends State<ReviewHomeworkScreen> {
  late final TextEditingController _gradeController;
  late final TextEditingController _feedbackController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _gradeController = TextEditingController(
      text: widget.submission.existingGrade?.toString() ?? '',
    );
    _feedbackController = TextEditingController(
      text: widget.submission.existingFeedback ?? '',
    );
  }

  @override
  void dispose() {
    _gradeController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _submitGrade() async {
    final l10 = AppLocalizations.of(context)!;
    final grade = int.tryParse(_gradeController.text.trim());

    if (grade == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10.enterAValidGrade)));
      return;
    }
    if (grade > 100) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10.gradeCannotExceed100)));
      return;
    }

    setState(() => _isSubmitting = true);

    // TODO: update Supabase `homework_submissions` row
    // (grade, feedback, graded_at) for widget.submission.id
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10.gradeSubmittedSuccessfully)));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.reviewHomework,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubmissionStudentHeader(submission: widget.submission),
                    const SizedBox(height: 16),

                    SubmissionFileCard(
                      fileName: widget.submission.fileName,
                      fileUrl: widget.submission.fileUrl,
                    ),
                    const SizedBox(height: 20),

                    GradeInputField(controller: _gradeController),
                    const SizedBox(height: 20),

                    CustomText(
                      text: l10.feedback,
                      style: TextStyle(
                        color: ColorManager.black.withValues(alpha: 0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _feedbackController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: l10.feedbackHint,
                        filled: true,
                        fillColor: ColorManager.gray.withValues(alpha: 0.06),
                        contentPadding: const EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Submit button pinned at the bottom
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitGrade,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          l10.submitGrade,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
