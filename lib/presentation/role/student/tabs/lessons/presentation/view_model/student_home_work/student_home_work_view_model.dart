import 'dart:io';

import 'package:edura/presentation/role/student/tabs/lessons/domain/use_case/student_home_work/student_home_work_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/student_home_work/homework_submission_model.dart';

@injectable
class StudentHomeWorkCubit extends Cubit<HomeworkSubmissionState> {
  final StudentHomeWorkUseCase useCase;

  StudentHomeWorkCubit({required this.useCase})
      : super(HomeworkSubmissionInitial());

  Future<HomeworkSubmissionModel> submit({
    required String homeworkId,
    required String studentId,
    required File file,
    DateTime? dueDate,
  }) async {
    if (!isClosed) emit(HomeworkSubmissionSubmitting());
    try {
      final submission = await useCase.submit(
        homeworkId: homeworkId,
        studentId: studentId,
        file: file,
        dueDate: dueDate,
      );
      if (!isClosed) emit(HomeworkSubmissionLoaded(submission));
      return submission;
    } catch (e) {
      if (!isClosed) emit(HomeworkSubmissionError(e.toString()));
      rethrow; // the card's _submit catches it
    }
  }

  Future<void> getMySubmission(String homeworkId, String studentId) async {
    if (isClosed) return;
    emit(HomeworkSubmissionLoading());
    try {
      final submission = await useCase.getMySubmission(homeworkId, studentId);
      if (isClosed) return;
      emit(HomeworkSubmissionLoaded(submission));
    } catch (e) {
      if (isClosed) return;
      emit(HomeworkSubmissionError(e.toString()));
    }
  }

  Future<List<HomeworkSubmissionModel>> getSubmissionsForHomework(
      String homeworkId,
      String studentId,
      ) async {
    if (!isClosed) emit(HomeworkSubmissionLoading());
    try {
      final submissions = await useCase.getSubmissionsForHomework(
        homeworkId,
        studentId,
      );
      if (!isClosed) emit(HomeworkSubmissionLoaded(null));
      return submissions;
    } catch (e) {
      if (!isClosed) emit(HomeworkSubmissionError(e.toString()));
      rethrow;
    }
  }
}

sealed class HomeworkSubmissionState {}

class HomeworkSubmissionInitial extends HomeworkSubmissionState {}

class HomeworkSubmissionLoading extends HomeworkSubmissionState {}

class HomeworkSubmissionSubmitting extends HomeworkSubmissionState {}

class HomeworkSubmissionLoaded extends HomeworkSubmissionState {
  final HomeworkSubmissionModel? submission;

  HomeworkSubmissionLoaded(this.submission);
}

class HomeworkSubmissionError extends HomeworkSubmissionState {
  final String message;

  HomeworkSubmissionError(this.message);
}