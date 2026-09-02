import 'dart:developer';

import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_elevated_button.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view_model/exam_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/section/exams/section/add_question_button.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/section/exams/section/exam_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/model/question_draft_model.dart';
import '../../../../../../../l10n/app_localizations.dart';
import 'section/exam_date_range_picker.dart';
import 'section/question_builder_card.dart';

class QuestionBuilderScreen extends StatefulWidget {
  const QuestionBuilderScreen({super.key});

  @override
  State<QuestionBuilderScreen> createState() => _QuestionBuilderScreenState();
}

class _QuestionBuilderScreenState extends State<QuestionBuilderScreen> {
  final List<QuestionDraftModel> _questions = [QuestionDraftModel()];

  late TextEditingController _titleController;
  late TextEditingController _subjectController;
  late TextEditingController _durationController;
  late GlobalKey<FormState> _formKey;

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _subjectController = TextEditingController();
    _durationController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _subjectController.dispose();
    _durationController.dispose();
  }

  void _addQuestion() {
    setState(() => _questions.add(QuestionDraftModel()));
  }

  void _deleteQuestion(int index) {
    setState(() => _questions.removeAt(index));
  }

  bool get _allQuestionsValid => _questions.every((q) => q.isValid);

  bool get _isDateRangeValid =>
      _startDate != null && _endDate != null && _endDate!.isAfter(_startDate!);

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.questionBuilder,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<ExamCubit, ExamState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExamHeader(
                      titleController: _titleController,
                      subjectController: _subjectController,
                      durationController: _durationController,
                    ),
                    const SizedBox(height: 16),

                    CustomText(
                      text: l10.availabilityWindow,
                      style: TextStyle(
                        color: ColorManager.black.withValues(alpha: 0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ExamDateRangePicker(
                      startDate: _startDate,
                      endDate: _endDate,
                      onStartDateChanged: (date) {
                        setState(() {
                          _startDate = date;
                          // clear an end date that's now invalid relative to the new start
                          if (_endDate != null && !_endDate!.isAfter(date)) {
                            _endDate = null;
                          }
                        });
                      },
                      onEndDateChanged: (date) => setState(() => _endDate = date),
                    ),
                    const SizedBox(height: 16),

                    ...List.generate(_questions.length, (index) {
                      return QuestionBuilderCard(
                        questionNumber: index + 1,
                        draft: _questions[index],
                        onChanged: () => setState(() {}),
                        onDelete: _questions.length > 1
                            ? () => _deleteQuestion(index)
                            : null,
                      );
                    }),

                    AddQuestionButton(onAddQuestion: _addQuestion),

                    CustomElevatedButton(
                      text: l10.publishExam(_questions.length),
                      onPressed: state is ExamLoading ? null : _publish,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is ExamSuccess) {
            Fluttertoast.showToast(
              msg: l10.examPublishedSuccessfully,
              backgroundColor: ColorManager.green,
              gravity: ToastGravity.BOTTOM,
            );
            Navigator.pop(context);
          }
          if (state is ExamFailure) {
            log('ExamFailure: ${state.message}');
            Fluttertoast.showToast(
              msg: l10.examPublishFailed,
              backgroundColor: ColorManager.red,
              gravity: ToastGravity.BOTTOM,
            );
          }

          if (state is ExamLoading) {
            Fluttertoast.showToast(
              msg: l10.examPublishing,
              backgroundColor: ColorManager.blue,
              gravity: ToastGravity.BOTTOM,
            );
          }
        },
      ),
    );
  }

  Future<void> _publish() async {
    final l10 = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_allQuestionsValid) {
      Fluttertoast.showToast(
        msg: l10.completeAllQuestionsBeforePublishing,
        backgroundColor: ColorManager.red,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    if (_startDate == null || _endDate == null) {
      Fluttertoast.showToast(
        msg: l10.selectStartAndEndDate,
        backgroundColor: ColorManager.red,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    if (!_isDateRangeValid) {
      Fluttertoast.showToast(
        msg: l10.endDateMustBeAfterStartDate,
        backgroundColor: ColorManager.red,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    final title = _titleController.text.trim();
    final subject = _subjectController.text.trim();
    final durationMinutes = int.parse(_durationController.text.trim());

    context.read<ExamCubit>().createExam(
      title: title,
      subject: subject,
      durationMinutes: durationMinutes,
      startDate: _startDate!,
      endDate: _endDate!,
      questions: _questions,
    );
  }
}