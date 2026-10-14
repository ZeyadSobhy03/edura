import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/exam_summary/exam_summary.dart';
import '../../../domain/use_case/exam_summary/exam_summary_use_case.dart';

@injectable
class ExamSummaryCubit extends Cubit<ExamSummaryState> {
  final ExamSummaryUseCase examSummaryUseCase;

  ExamSummaryCubit({
    required this.examSummaryUseCase,
  }) : super(ExamSummaryLoading());

  Future<void> loadExams() async {
    emit(ExamSummaryLoading());

    try {
      final exams = await examSummaryUseCase.fetchExams();

      emit(ExamsSummaryLoaded(exams));
    } catch (e) {
      emit(ExamSummaryError(e.toString()));
    }
  }
}

sealed class ExamSummaryState {}

class ExamSummaryLoading extends ExamSummaryState {}

class ExamsSummaryLoaded extends ExamSummaryState {
  final List<ExamSummaryModel> exams;

  ExamsSummaryLoaded(this.exams);
}

class ExamSummaryError extends ExamSummaryState {
  final String message;

  ExamSummaryError(this.message);
}