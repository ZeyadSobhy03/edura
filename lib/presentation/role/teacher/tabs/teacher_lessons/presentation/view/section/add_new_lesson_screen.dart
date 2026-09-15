
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/localization/error_messages.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/home_work/new_homework_model.dart';
import '../../../data/model/lessons/new_lesson_model.dart';
import '../../view_model/home_work/home_work_view_model.dart';
import '../../view_model/lessons/teacher_lessons_view_model.dart';
import '../widgets/lesson_form_tab_selector.dart';
import '../widgets/lesson_homework_upload_form.dart';
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
  bool _homeworkStepReached = false;

  NewHomeworkModel? _pendingHomework;

  void _goToStep(LessonFormStep step) {
    setState(() => _step = step);
  }

  void _saveDraft() {
    _draft.isPublished = false;
    _pendingHomework = null;
    context.read<TeacherLessonsCubit>().createLesson(_draft);
  }

  void _publishWithoutHomework() {
    _draft.isPublished = true;
    _pendingHomework = null;
    context.read<TeacherLessonsCubit>().createLesson(_draft);
  }

  void _publishWithHomework(NewHomeworkModel homework) {
    _draft.isPublished = true;
    _pendingHomework = homework;
    context.read<TeacherLessonsCubit>().createLesson(_draft);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return MultiBlocListener(
      listeners: [
        BlocListener<TeacherLessonsCubit, TeacherLessonsState>(
          listener: (context, state) {
            if (state is CreateLessonSuccess) {
              final homework = _pendingHomework;
              if (homework == null) {
                Fluttertoast.showToast(
                  msg: state.lesson.isPublished
                      ? l10.lessonPublishedSuccessfully
                      : l10.lessonSavedAsDraft,
                );
                Navigator.pop(context, state.lesson);
              } else {
                context.read<HomeWorkCubit>().createHomework(
                  lessonId: state.lesson.id,
                  homework: homework,
                );
              }
            } else if (state is CreateLessonFailure) {
              if (!context.mounted) return;
              Fluttertoast.showToast(
                msg: ErrorMessages.get(context, state.error),
              );
            }
          },
        ),
        BlocListener<HomeWorkCubit, HomeWorkState>(
          listener: (context, state) {
            if (state is CreateHomeworkSuccess) {
              Fluttertoast.showToast(msg: l10.lessonPublishedSuccessfully);

              Navigator.pop(context);
            } else if (state is CreateHomeworkFailure) {
              Fluttertoast.showToast(
                msg: ErrorMessages.get(context, state.error),
              );

              Navigator.pop(context);
            }
          },
        ),
      ],
      child: BlocBuilder<TeacherLessonsCubit, TeacherLessonsState>(
        builder: (context, lessonState) {
          return BlocBuilder<HomeWorkCubit, HomeWorkState>(
            builder: (context, homeworkState) {
              final isSubmitting =
                  lessonState is TeacherLessonsLoading ||
                  lessonState is TeacherLessonsSubmitting ||
                  homeworkState is HomeWorkSubmitting;

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
                          homeworkDone: _homeworkStepReached,
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
                        else if (_step == LessonFormStep.pdf)
                          LessonPdfUploadForm(
                            draft: _draft,
                            onPublish: () {
                              setState(() {
                                _homeworkStepReached = true;
                                _step = LessonFormStep.homework;
                              });
                            },
                            onSaveDraft: _saveDraft,
                            isPublishing: isSubmitting,
                          )
                        else
                          LessonHomeworkUploadForm(
                            onNext: _publishWithHomework,
                            onSkip: _publishWithoutHomework,
                            isSubmitting: isSubmitting,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
