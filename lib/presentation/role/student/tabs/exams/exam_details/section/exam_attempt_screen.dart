import 'dart:async';

import 'package:edura/core/model/exam_model.dart';
import 'package:edura/core/model/question_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/presentation/role/student/tabs/exams/exam_details/section/question_card.dart';
import 'package:flutter/material.dart';

import '../../../../../../../l10n/app_localizations.dart';
import 'answer_option_tile.dart';
import 'exam_attempt_header.dart';
import 'exam_result_screen.dart';


class ExamAttemptScreen extends StatefulWidget {
  const ExamAttemptScreen({
    super.key,
    required this.exam,
    required this.questions,
  });

  final ExamModel exam;
  final List<QuestionModel> questions;

  @override
  State<ExamAttemptScreen> createState() => _ExamAttemptScreenState();
}

class _ExamAttemptScreenState extends State<ExamAttemptScreen> {
  int _currentIndex = 0;
  late int _remainingSeconds;
  Timer? _timer;

  final Map<int, int> _selectedAnswers = {};

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.exam.durationMinutes * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
        _submitExam();
        return;
      }
      setState(() => _remainingSeconds--);
    });
  }

  void _selectOption(int optionIndex) {
    setState(() {
      _selectedAnswers[_currentIndex] = optionIndex;
    });
  }

  void _goToNext() {
    if (_currentIndex < widget.questions.length - 1) {
      setState(() => _currentIndex++);
    } else {
      _submitExam();
    }
  }

  void _submitExam() {
    _timer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ExamResultScreen(
          exam: widget.exam,
          questions: widget.questions,
          selectedAnswers: _selectedAnswers,
        ),
      ),
    );
  }

  void _confirmExit() {
    final l10 = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10.exitExamTitle),
        content: Text(l10.exitExamDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
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
    final l10 = AppLocalizations.of(context)!;
    final question = widget.questions[_currentIndex];
    final selectedOption = _selectedAnswers[_currentIndex];
    final optionLabels = ['A', 'B', 'C', 'D', 'E', 'F'];

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Column(
          children: [
            ExamAttemptHeader(
              onExit: _confirmExit,
              remainingSeconds: _remainingSeconds,
              currentQuestion: _currentIndex + 1,
              totalQuestions: widget.questions.length,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuestionCard(
                      questionNumber: _currentIndex + 1,
                      questionText: question.questionText,
                    ),
                    const SizedBox(height: 16),
                    ...List.generate(question.options.length, (index) {
                      return AnswerOptionTile(
                        label: optionLabels[index],
                        text: question.options[index],
                        isSelected: selectedOption == index,
                        onTap: () => _selectOption(index),
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
                  onPressed: selectedOption != null ? _goToNext : null,
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
                    _currentIndex == widget.questions.length - 1
                        ? l10.submit
                        : l10.next,
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
  }
}