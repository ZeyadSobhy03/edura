import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_elevated_button.dart';
import 'package:edura/core/widgets/custom_label.dart';
import 'package:edura/core/widgets/custom_switch_card.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/widgets/change_video_card.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class EditLessonScreen extends StatefulWidget {
  const EditLessonScreen({super.key, required this.lesson});

  final LessonModel lesson;

  @override
  State<EditLessonScreen> createState() => _EditLessonScreenState();
}

class _EditLessonScreenState extends State<EditLessonScreen> {
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
              ),
              const SizedBox(height: 8),
              CustomLabel(
                label: l10.lessonTitle,
                color: ColorManager.salatGray,
              ),
              const SizedBox(height: 8),
              CustomTextFormedField(
                hintText: l10.enterLessonTitle,
                initialValue: widget.lesson.title,
              ),
              const SizedBox(height: 8),
              CustomLabel(
                label: l10.lessonDescription,
                color: ColorManager.salatGray,
              ),
              const SizedBox(height: 8),
              CustomTextFormedField(
                hintText: l10.enterLessonDescription,
                initialValue: widget.lesson.overviewDescription,
                maxLines: 4,
              ),
              const SizedBox(height: 8),
              CustomSwitchCard(
                title: l10.published,
                subtitle: l10.publishedSubtitle,
                value: widget.lesson.isPublished,
                onChanged: (value) {
                  setState(() {
                    widget.lesson.isPublished = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              CustomElevatedButton(text: l10.saveChanges, onPressed: () {}),
              const SizedBox(height: 8),
              CustomElevatedButton(
                text: l10.deleteLesson,
                onPressed: () {},
                backgroundColor: ColorManager.red.withValues(alpha: 0.1),
                foregroundColor: ColorManager.red,

              ),
            ],
          ),
        ),
      ),
    );
  }
}
