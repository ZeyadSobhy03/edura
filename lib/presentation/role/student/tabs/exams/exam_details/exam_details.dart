import 'package:edura/core/model/exam_attempt_arguments.dart';
import 'package:edura/core/model/exam_model.dart';
import 'package:edura/core/model/question_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_elevated_button.dart';
import 'package:edura/presentation/role/student/tabs/exams/exam_details/section/exam_detail_header.dart';
import 'package:edura/presentation/role/student/tabs/exams/widgets/quiz_stat_card.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';
import 'section/exam_instructions_card.dart';
import 'section/exam_requirements_card.dart';

class ExamDetails extends StatefulWidget {
  const ExamDetails({super.key});

  @override
  State<ExamDetails> createState() => _ExamDetailsState();
}

class _ExamDetailsState extends State<ExamDetails> {
  late ExamModel exam;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    exam = ModalRoute.of(context)!.settings.arguments as ExamModel;
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ExamDetailHeader(
                      examTitle: exam.title,
                      subjectName: exam.subject,
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: QuizStatCard(
                              icon: Icons.timer_outlined,
                              title: l10.min,
                              value: exam.durationMinutes,
                              color: ColorManager.primary,
                            ),
                          ),
                          Expanded(
                            child: QuizStatCard(
                              icon: Icons.question_mark_outlined,
                              title: l10.questions,
                              value: exam.questionsCount,
                              color: ColorManager.purple,
                            ),
                          ),
                          Expanded(
                            child: QuizStatCard(
                              icon: Icons.star_border_outlined,
                              title: l10.totalScore,
                              value: exam.score?.toInt() ?? 0,
                              color: ColorManager.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExamInstructionsCard(
                        instructions: exam.instructions,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExamRequirementsCard(
                        requirements: exam.requirements,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomElevatedButton(
                text: l10.startExam,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RouteManger.examAttemptScreen,
                    arguments: ExamAttemptArguments(
                      exam: exam,
                      questions: DummyQuestionData.calculusQuestions,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
