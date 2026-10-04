import 'package:edura/presentation/role/student/tabs/exams/domain/use_case/exam_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/model/exam_model.dart';
import '../../data/model/student_question.dart';
import '../../data/model/student_question_model.dart';

@injectable
class StudentExamCubit extends Cubit<ExamState> {
  final ExamUseCase examUseCase;

  StudentExamCubit({required this.examUseCase}) : super(ExamInitial());

  String? _studentId;

  Future<void> loadExams({required String studentId}) async {
    _studentId = studentId;
    emit(ExamsLoading());
    try {
      final exams = await examUseCase.fetchExams(studentId: studentId);
      emit(ExamsLoaded(exams));
    } catch (e) {
      emit(ExamError(_messageOf(e)));
    }
  }

  Future<void> fetchReview(String examId) async {
    if (_studentId == null) {
      emit(ExamError('Student ID is not set.'));
      return;
    }
    emit(ExamReviewLoading());
    try {
      final reviewQuestions = await examUseCase.fetchReview(
        examId,
        studentId: _studentId!,
      );
      emit(ExamReview(reviewQuestions));
    } catch (e) {
      emit(ExamError(_messageOf(e)));
    }

  }

  Future<void> startExam(String examId, {required String studentId}) async {
    _studentId = studentId;
    emit(ExamStarting());
    try {
      final started = await examUseCase.startExam(examId, studentId: studentId);
      emit(
        ExamInProgress(
          examId: examId,
          attemptId: started.attemptId,
          questions: started.questions,
        ),
      );
    } catch (e) {
      emit(ExamError(_messageOf(e)));
    }
  }

  void selectAnswer(String questionId, int optionIndex) {
    final current = state;
    if (current is! ExamInProgress) return;
    emit(
      current.copyWith(
        answers: {...current.answers, questionId: optionIndex},
        clearError: true,
      ),
    );
  }

  void goToQuestion(int index) {
    final current = state;
    if (current is! ExamInProgress) return;
    if (index < 0 || index >= current.questions.length) return;
    emit(current.copyWith(currentIndex: index));
  }

  void next() {
    final current = state;
    if (current is ExamInProgress) goToQuestion(current.currentIndex + 1);
  }

  void previous() {
    final current = state;
    if (current is ExamInProgress) goToQuestion(current.currentIndex - 1);
  }

  Future<void> submitExam() async {
    final current = state;
    if (current is! ExamInProgress || _studentId == null) return;

    emit(ExamSubmitting());
    try {
      final result = await examUseCase.submitExam(
        attemptId: current.attemptId,
        studentId: _studentId!,
        answers: current.answers,
      );
      emit(ExamSubmitted(result));
    } catch (e) {
      emit(current.copyWith(submitError: _messageOf(e)));
    }
  }

  String _messageOf(Object e) {
    if (e is PostgrestException) return e.message;
    if (e is AuthException) return e.message;
    return e.toString().replaceFirst('Exception: ', '');
  }
}

sealed class ExamState {}

class ExamInitial extends ExamState {}

class ExamsLoading extends ExamState {}

class ExamsLoaded extends ExamState {
  final List<ExamModel> exams;

  ExamsLoaded(this.exams);
}

class ExamStarting extends ExamState {}

class ExamInProgress extends ExamState {
  final String examId;
  final String attemptId;
  final List<StudentQuestionModel> questions;
  final Map<String, int> answers;
  final int currentIndex;
  final String? submitError;

  ExamInProgress({
    required this.examId,
    required this.attemptId,
    required this.questions,
    this.answers = const {},
    this.currentIndex = 0,
    this.submitError,
  });

  int get answeredCount => answers.length;

  ExamInProgress copyWith({
    Map<String, int>? answers,
    int? currentIndex,
    String? submitError,
    bool clearError = false,
  }) {
    return ExamInProgress(
      examId: examId,
      attemptId: attemptId,
      questions: questions,
      answers: answers ?? this.answers,
      currentIndex: currentIndex ?? this.currentIndex,
      submitError: clearError ? null : (submitError ?? this.submitError),
    );
  }
}

class ExamSubmitting extends ExamState {}

class ExamSubmitted extends ExamState {
  final ExamResultModel result;

  ExamSubmitted(this.result);
}

class ExamReview extends ExamState {
  final List<ReviewQuestionModel> questions;

  ExamReview(this.questions);
}

class ExamReviewLoading extends ExamState {}

class ExamError extends ExamState {
  final String message;

  ExamError(this.message);
}
