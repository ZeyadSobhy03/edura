import 'package:edura/core/error/app_error.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/home_work/new_homework_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/domain/use_case/home_work/home_work_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LessonHomeworksCubit extends Cubit<LessonHomeworksState> {
  final HomeWorkUseCase useCase;

  LessonHomeworksCubit({required this.useCase})
      : super(LessonHomeworksInitial());

  Future<void> fetch(String lessonId) async {
    emit(LessonHomeworksLoading());
    try {
      emit(LessonHomeworksLoaded(await useCase.getHomeworksByLesson(lessonId)));
    } on AppError catch (e) {
      emit(LessonHomeworksFailure(e));
    } catch (_) {
      emit(LessonHomeworksFailure(const UnknownServerError()));
    }
  }
}

sealed class LessonHomeworksState {}

class LessonHomeworksInitial extends LessonHomeworksState {}

class LessonHomeworksLoading extends LessonHomeworksState {}

class LessonHomeworksLoaded extends LessonHomeworksState {
  final List<NewHomeworkModel> homeworks;
  LessonHomeworksLoaded(this.homeworks);
}

class LessonHomeworksFailure extends LessonHomeworksState {
  final AppError error;
  LessonHomeworksFailure(this.error);
}