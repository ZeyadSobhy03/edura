import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/student_exam_review/student_exam_review.dart';
import '../../../domain/use_case/student_exam_review/student_exam_review_use_case.dart';

@injectable
class StudentExamReviewCubit extends Cubit<StudentReviewState> {
  final StudentExamReviewUseCase studentExamReviewUseCase;

  StudentExamReviewCubit({required this.studentExamReviewUseCase})
    : super(StudentReviewLoading());

  Future<void> load(int examId, String studentId) async {
    emit(StudentReviewLoading());
    try {
      final data = await studentExamReviewUseCase.examReview(examId, studentId);
      emit(StudentReviewLoaded(data));
    } catch (e) {
      emit(StudentReviewError(e.toString()));
    }
  }
}

sealed class StudentReviewState {}

class StudentReviewLoading extends StudentReviewState {}

class StudentReviewLoaded extends StudentReviewState {
  final StudentReviewData data;

  StudentReviewLoaded(this.data);
}

class StudentReviewError extends StudentReviewState {
  final String message;

  StudentReviewError(this.message);
}
