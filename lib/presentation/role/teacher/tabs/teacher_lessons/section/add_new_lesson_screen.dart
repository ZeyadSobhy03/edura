import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/new_lesson_draft_model.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../widgets/lesson_form_tab_selector.dart';
import '../widgets/lesson_pdf_upload_form.dart';
import '../widgets/lesson_video_upload_form.dart';
import 'lesson_details_form.dart';


class AddNewLessonScreen extends StatefulWidget {
  const AddNewLessonScreen({super.key});

  @override
  State<AddNewLessonScreen> createState() => _AddNewLessonScreenState();
}

class _AddNewLessonScreenState extends State<AddNewLessonScreen> {
  LessonFormStep _step = LessonFormStep.details;
  final NewLessonDraftModel _draft = NewLessonDraftModel();
  bool _videoStepReached = false;
  bool _pdfStepReached = false;
  bool _isPublishing = false;

  void _goToStep(LessonFormStep step) {
    setState(() => _step = step);
  }

  Future<void> _publish() async {
    setState(() => _isPublishing = true);

    // TODO: upload _draft.videoFile and _draft.pdfFile to Supabase storage,
    // then insert lesson metadata (_draft.title, duration, subject, etc.)
    // into your `lessons` table.
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isPublishing = false);

    final l10 = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10.lessonPublishedSuccessfully)),
    );
    Navigator.pop(context);
  }

  Future<void> _saveDraft() async {
    // TODO: insert into `lessons` table with a `status: draft` flag
    final l10 = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10.lessonSavedAsDraft)),
    );
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
          text: l10.addNewLesson,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LessonFormTabSelector(
                currentStep: _step,
                onStepTapped: _goToStep,
                videoDone: _videoStepReached,
                pdfDone: _pdfStepReached,
              ),
              const SizedBox(height: 20),

              if (_step == LessonFormStep.details)
                LessonDetailsForm(
                  draft: _draft,
                  onNext: () {
                    setState(() {
                      _videoStepReached = true;
                      _step = LessonFormStep.video;
                    });
                  },
                )
              else if (_step == LessonFormStep.video)
                LessonVideoUploadForm(
                  draft: _draft,
                  onNext: () {
                    setState(() {
                      _pdfStepReached = true;
                      _step = LessonFormStep.pdf;
                    });
                  },
                )
              else
                LessonPdfUploadForm(
                  draft: _draft,
                  onPublish: _publish,
                  onSaveDraft: _saveDraft,
                  isPublishing: _isPublishing,
                ),
            ],
          ),
        ),
      ),
    );
  }
}