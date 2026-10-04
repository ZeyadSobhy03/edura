import 'dart:async';

import 'package:edura/core/model/exam_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/presentation/role/student/tabs/exams/presentation/view/exam_details/section/question_card.dart';
import 'package:edura/presentation/role/student/tabs/exams/presentation/view_model/exam_view_model.dart'; // file that contains StudentExamCubit
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../../core/resources/routes/route_manger.dart';
import '../../../../../../../../../l10n/app_localizations.dart';
import 'answer_option_tile.dart';
import 'exam_attempt_header.dart';
import 'exam_result_screen.dart';

class ExamAttemptScreen extends StatefulWidget {
  const ExamAttemptScreen({super.key, required this.exam});

  final ExamModel exam;

  @override
  State<ExamAttemptScreen> createState() => _ExamAttemptScreenState();
}

class _ExamAttemptScreenState extends State<ExamAttemptScreen> {
  late int _remainingSeconds = widget.exam.durationMinutes * 60;
  Timer? _timer;
  bool _timerStarted = false;
  String? studentId;

  @override
  void initState() {
    super.initState();
    studentId = Supabase.instance.client.auth.currentUser?.id;
    if (studentId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, RouteManger.loginRoute);
      });
      return;
    }

    context
        .read<StudentExamCubit>()
        .startExam(widget.exam.id, studentId: studentId!);
  }

  void _startTimer() {
    if (_timerStarted) return;
    _timerStarted = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_remainingSeconds <= 1) {
        timer.cancel();
        setState(() => _remainingSeconds = 0);
        context.read<StudentExamCubit>().submitExam();
        return;
      }
      setState(() => _remainingSeconds--);
    });
  }

  void _submit() {
    _timer?.cancel();
    context.read<StudentExamCubit>().submitExam();
  }

  void _confirmExit() {
    final l10 = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10.exitExamTitle),
        content: Text(l10.exitExamDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _submit();
            },
            child: Text(l10.exit, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (studentId == null) return const Scaffold(body: SizedBox.shrink());

    return BlocConsumer<StudentExamCubit, ExamState>(
      listener: (context, state) {
        if (state is ExamInProgress) {
          _startTimer();
          if (state.submitError != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.submitError!)));
          }
        }
        if (state is ExamSubmitted) {
          _timer?.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ExamResultScreen(
                exam: widget.exam,
                result: state.result,
              ),
            ),
          );
        }
        if (state is ExamError) _timer?.cancel();
      },
      builder: (context, state) {
        final active = state is ExamInProgress || state is ExamSubmitting;

        return PopScope(
          canPop: !active,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop && state is ExamInProgress) _confirmExit();
          },
          child: Scaffold(
            backgroundColor: ColorManager.white,
            body: SafeArea(child: _body(context, state)),
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context, ExamState state) {
    if (state is ExamError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: ColorManager.red, fontSize: 16),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      );
    }

    if (state is! ExamInProgress) {
      return const Center(
        child: CircularProgressIndicator(color: ColorManager.primary),
      );
    }

    final l10 = AppLocalizations.of(context)!;
    final cubit = context.read<StudentExamCubit>();
    final question = state.questions[state.currentIndex];
    final selectedOption = state.answers[question.id];
    final isLast = state.currentIndex == state.questions.length - 1;
    final optionLabels = ['A', 'B', 'C', 'D', 'E', 'F'];

    return Column(
      children: [
        ExamAttemptHeader(
          onExit: _confirmExit,
          remainingSeconds: _remainingSeconds,
          currentQuestion: state.currentIndex + 1,
          totalQuestions: state.questions.length,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuestionCard(
                  questionNumber: state.currentIndex + 1,
                  questionText: question.questionText,
                ),
                const SizedBox(height: 16),
                ...List.generate(question.options.length, (index) {
                  return AnswerOptionTile(
                    label: optionLabels[index],
                    text: question.options[index],
                    isSelected: selectedOption == index,
                    onTap: () => cubit.selectAnswer(question.id, index),
                  );
                }),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(

              onPressed: (selectedOption != null || state.submitError != null)
                  ? (isLast ? _submit : cubit.next)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                disabledBackgroundColor:
                ColorManager.gray.withValues(alpha: 0.3),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                isLast ? l10.submit : l10.next,
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
    );
  }
}