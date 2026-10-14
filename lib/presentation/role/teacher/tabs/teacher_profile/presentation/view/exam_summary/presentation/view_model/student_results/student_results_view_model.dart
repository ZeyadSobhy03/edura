import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_case/exam_summary/exam_summary_use_case.dart';
import '../../../data/model/exam_summary/exam_summary.dart';

@injectable
class StudentResultsCubit extends Cubit<StudentResultsState> {
  final ExamSummaryUseCase examSummaryUseCase;

  StudentResultsCubit({
    required this.examSummaryUseCase,
  }) : super(StudentResultsLoading());

  Future<void> loadResults(int examId) async {
    emit(StudentResultsLoading());

    try {
      final results = await examSummaryUseCase.fetchResults(examId);

      emit(StudentResultsLoaded(results));
    } catch (e) {
      emit(StudentResultsError(e.toString()));
    }
  }
}

sealed class StudentResultsState {}

class StudentResultsLoading extends StudentResultsState {}

class StudentResultsLoaded extends StudentResultsState {
  final List<StudentResultModel> results;

  StudentResultsLoaded(this.results);
}

class StudentResultsError extends StudentResultsState {
  final String message;

  StudentResultsError(this.message);
}