import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/localization/error_messages.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../core/model/homework_submission_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/home_work/home_work_view_model.dart';
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

    context.read<HomeWorkCubit>().reviewHomework(
      submissionId: widget.submission.id,
      grade: grade,
      feedback: _feedbackController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return BlocConsumer<HomeWorkCubit, HomeWorkState>(
      listener: (context, state) {
        if (state is ReviewHomeworkSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10.gradeSubmittedSuccessfully)),
          );
          Navigator.pop(context, true);
        } else if (state is ReviewHomeworkFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(ErrorMessages.get(context, state.error))),
          );
        }
      },
      builder: (context, state) {
        final isSubmitting = state is HomeWorkSubmitting;

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
                            fillColor: ColorManager.gray.withValues(
                              alpha: 0.06,
                            ),
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
                      onPressed: isSubmitting ? null : _submitGrade,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isSubmitting
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
      },
    );
  }
}
