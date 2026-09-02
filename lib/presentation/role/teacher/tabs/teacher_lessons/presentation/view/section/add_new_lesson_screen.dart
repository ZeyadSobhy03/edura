import 'dart:developer';

import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/localization/error_messages.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/new_lesson_model.dart';
import '../../view_model/teacher_lessons_view_model.dart';
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
  final NewLessonModel _draft = NewLessonModel();
  bool _videoStepReached = false;
  bool _pdfStepReached = false;

  void _goToStep(LessonFormStep step) {
    setState(() => _step = step);
  }

  void _publish() {
    _draft.isPublished = true;
    context.read<TeacherLessonsCubit>().createLesson(_draft);
  }

  void _saveDraft() {
    _draft.isPublished = false;
    context.read<TeacherLessonsCubit>().createLesson(_draft);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return BlocConsumer<TeacherLessonsCubit, TeacherLessonsState>(
      listener: (context, state) {
        if (state is CreateLessonSuccess) {
          Fluttertoast.showToast(
            msg: state.lesson.isPublished
                ? l10.lessonPublishedSuccessfully
                : l10.lessonSavedAsDraft,
          );

          Navigator.pop(context, state.lesson);
        } else if (state is CreateLessonFailure) {
          log('CreateLessonFailure: ${state.error}');
          Fluttertoast.showToast(msg: ErrorMessages.get(context, state.error));
        }
      },
      builder: (context, state) {
        final isSubmitting = state is TeacherLessonsLoading;

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
                    onStepTapped: isSubmitting ? (_) {} : _goToStep,
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
                      isPublishing: isSubmitting,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
