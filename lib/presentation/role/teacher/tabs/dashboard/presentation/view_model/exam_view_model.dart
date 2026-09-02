import 'package:edura/presentation/role/teacher/tabs/dashboard/domain/use_case/exam_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/question_draft_model.dart';

class ExamCubit extends Cubit<ExamState> {
  final ExamUseCase examUseCase;

  ExamCubit({required this.examUseCase}) : super(ExamInitial());

  Future<void> createExam({
    required String title,
    required String subject,
    required int durationMinutes,
    required List<QuestionDraftModel> questions,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    emit(ExamLoading());
    try {
      final result = await examUseCase.createExam(
        title: title,
        subject: subject,
        durationMinutes: durationMinutes,
        questions: questions,
        startDate: startDate,
        endDate: endDate
      );
      emit(ExamSuccess(data: result));
    } catch (e) {
      emit(ExamFailure(message: e.toString()));
    }
  }
}

sealed class ExamState {}

class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamSuccess extends ExamState {
  final Map<String, dynamic> data;

  ExamSuccess({required this.data});
}

class ExamFailure extends ExamState {
  final String message;

  ExamFailure({required this.message});
}
