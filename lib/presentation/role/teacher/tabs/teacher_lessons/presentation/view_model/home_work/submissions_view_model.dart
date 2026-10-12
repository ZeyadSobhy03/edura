import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../core/error/app_error.dart';
import '../../../../../../student/tabs/lessons/data/model/student_home_work/homework_submission_model.dart';
import '../../../domain/use_case/home_work/home_work_use_case.dart';

@injectable
class HomeworkSubmissionsCubit extends Cubit<HomeworkSubmissionsState> {
  final HomeWorkUseCase useCase;
  HomeworkSubmissionsCubit({required this.useCase})
      : super(SubmissionsInitial());

  Future<void> fetch(String homeworkId) async {
    emit(SubmissionsLoading());
    try {
      emit(SubmissionsLoaded(await useCase.getSubmissionsByHomework(homeworkId)));
    } on AppError catch (e) {
      emit(SubmissionsFailure(e));
    } catch (_) {
      emit(SubmissionsFailure(const UnknownServerError()));
    }
  }
}

sealed class HomeworkSubmissionsState {}
class SubmissionsInitial extends HomeworkSubmissionsState {}
class SubmissionsLoading extends HomeworkSubmissionsState {}
class SubmissionsLoaded extends HomeworkSubmissionsState {
  final List<HomeworkSubmissionModel> submissions;
  SubmissionsLoaded(this.submissions);
}
class SubmissionsFailure extends HomeworkSubmissionsState {
  final AppError error;
  SubmissionsFailure(this.error);
}