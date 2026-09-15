import 'dart:developer';
import 'dart:io';

import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/localization/error_messages.dart';
import 'package:edura/core/widgets/custom_elevated_button.dart';
import 'package:edura/core/widgets/custom_label.dart';
import 'package:edura/core/widgets/custom_switch_card.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/lessons/new_lesson_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view_model/lessons/teacher_lessons_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../widgets/change_video_card.dart';

class EditLessonScreen extends StatefulWidget {
  const EditLessonScreen({super.key, required this.lesson});

  final LessonModel lesson;

  @override
  State<EditLessonScreen> createState() => _EditLessonScreenState();
}

class _EditLessonScreenState extends State<EditLessonScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late bool _isPublished;
  File? _newVideoFile;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.lesson.title);
    _descriptionController =
        TextEditingController(text: widget.lesson.overviewDescription);
    _isPublished = widget.lesson.isPublished;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final lesson = NewLessonModel(
      title: _titleController.text.trim(),
      durationMinutes: widget.lesson.durationMinutes,
      subject: widget.lesson.subject,
      description: _descriptionController.text.trim(),
      isPublished: _isPublished,
      videoFile: _newVideoFile,
    );


    log('Updating lesson: ${lesson.title}, ${lesson.description}, isPublished: ${lesson.isPublished}, videoFile: ${lesson.videoFile?.path}, lesson id : ${widget.lesson.id}');
    context.read<TeacherLessonsCubit>().updateLesson(
          lessonId: widget.lesson.id,
          lesson: lesson,
          currentVideoUrl: widget.lesson.videoUrl,
          currentPdfUrl: widget.lesson.pdfUrl,
        );
  }

  Future<void> _confirmDelete() async {
    final l10 = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10.deleteLesson),
        content: Text(l10.deleteLessonConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              l10.delete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      context.read<TeacherLessonsCubit>().deleteLesson(widget.lesson.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return BlocConsumer<TeacherLessonsCubit, TeacherLessonsState>(
      listener: (context, state) {
        if (state is UpdateLessonSuccess) {
          Fluttertoast.showToast(msg: l10.lessonUpdatedSuccessfully);
          Navigator.pop(context, state.lesson);
        } else if (state is DeleteLessonSuccess) {
          Fluttertoast.showToast(msg: l10.lessonDeletedSuccessfully);
          Navigator.pop(context);
        } else if (state is UpdateLessonFailure) {
          Fluttertoast.showToast(msg: ErrorMessages.get(context, state.error));
        } else if (state is DeleteLessonFailure) {
          Fluttertoast.showToast(msg: ErrorMessages.get(context, state.error));
        }
      },
      builder: (context, state) {
        final isSubmitting = state is TeacherLessonsSubmitting;

        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0,
            centerTitle: true,
            title: CustomText(
              text: l10.editLesson,
              style: TextStyle(
                color: ColorManager.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ChangeVideoCard(
                    videoThumbnailUrl: widget.lesson.videoThumbnailUrl,
                    videoUrl: widget.lesson.videoUrl,
                    onVideoSelected: (file) => _newVideoFile = file,
                  ),
                  const SizedBox(height: 8),
                  CustomLabel(
                    label: l10.lessonTitle,
                    color: ColorManager.salatGray,
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormedField(
                    hintText: l10.enterLessonTitle,
                    controller: _titleController,
                  ),
                  const SizedBox(height: 8),
                  CustomLabel(
                    label: l10.lessonDescription,
                    color: ColorManager.salatGray,
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormedField(
                    hintText: l10.enterLessonDescription,
                    controller: _descriptionController,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 8),
                  CustomSwitchCard(
                    title: l10.published,
                    subtitle: l10.publishedSubtitle,
                    value: _isPublished,
                    onChanged: isSubmitting
                        ? null
                        : (value) => setState(() => _isPublished = value),
                  ),
                  const SizedBox(height: 8),
                  CustomElevatedButton(
                    text: l10.saveChanges,
                    onPressed: isSubmitting ? null : _saveChanges,
                  ),
                  const SizedBox(height: 8),
                  CustomElevatedButton(
                    text: l10.deleteLesson,
                    onPressed: isSubmitting ? null : _confirmDelete,
                    backgroundColor: ColorManager.red.withValues(alpha: 0.1),
                    foregroundColor: ColorManager.red,
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
