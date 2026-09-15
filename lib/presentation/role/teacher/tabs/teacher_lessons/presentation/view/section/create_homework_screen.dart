import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/home_work/new_homework_model.dart';
import '../widgets/homework_attachment_upload_form.dart';
import 'homework_details_form.dart';

enum HomeworkFormStep { details, attachments }

class CreateHomeworkScreen extends StatefulWidget {
  const CreateHomeworkScreen({super.key});

  @override
  State<CreateHomeworkScreen> createState() => _CreateHomeworkScreenState();
}

class _CreateHomeworkScreenState extends State<CreateHomeworkScreen> {
  HomeworkFormStep _step = HomeworkFormStep.details;
  final NewHomeworkModel _draft = NewHomeworkModel();
  bool _detailsStepReached = false;

  void _goToStep(HomeworkFormStep step) {
    setState(() => _step = step);
  }

  void _publish() {
    _draft.isPublished = true;
    // TODO: Implement homework creation in cubit
    // context.read<TeacherLessonsCubit>().createHomework(_draft);
    Fluttertoast.showToast(msg: 'Homework published successfully');
    Navigator.pop(context, _draft);
  }

  void _saveDraft() {
    _draft.isPublished = false;
    // TODO: Implement homework creation in cubit
    // context.read<TeacherLessonsCubit>().createHomework(_draft);
    Fluttertoast.showToast(msg: 'Homework saved as draft');
    Navigator.pop(context, _draft);
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
          text: l10.createHomework,
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
              // Step indicator
              Row(
                children: [
                  Expanded(
                    child: _buildStepIndicator(
                      label: l10.details,
                      isActive: _step == HomeworkFormStep.details,
                      isCompleted: _detailsStepReached,
                      onTap: () => _goToStep(HomeworkFormStep.details),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 30,
                    color: _detailsStepReached
                        ? ColorManager.primary
                        : ColorManager.gray.withValues(alpha: 0.3),
                  ),
                  Expanded(
                    child: _buildStepIndicator(
                      label: l10.attachments,
                      isActive: _step == HomeworkFormStep.attachments,
                      isCompleted: false,
                      onTap: _detailsStepReached
                          ? () => _goToStep(HomeworkFormStep.attachments)
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              if (_step == HomeworkFormStep.details)
                HomeworkDetailsForm(
                  draft: _draft,
                  onNext: () {
                    setState(() {
                      _detailsStepReached = true;
                      _step = HomeworkFormStep.attachments;
                    });
                  },
                )
              else
                HomeworkAttachmentUploadForm(
                  draft: _draft,
                  onPublish: _publish,
                  onSaveDraft: _saveDraft,
                  isPublishing: false,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator({
    required String label,
    required bool isActive,
    required bool isCompleted,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive || isCompleted
                  ? ColorManager.primary
                  : ColorManager.gray.withValues(alpha: 0.3),
            ),
            child: Center(
              child: isCompleted
                  ? Icon(Icons.check, color: ColorManager.white, size: 20)
                  : CustomText(
                      text: label[0],
                      style: TextStyle(
                        color: ColorManager.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          CustomText(
            text: label,
            style: TextStyle(
              color: isActive || isCompleted
                  ? ColorManager.primary
                  : ColorManager.black.withValues(alpha: 0.5),
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
