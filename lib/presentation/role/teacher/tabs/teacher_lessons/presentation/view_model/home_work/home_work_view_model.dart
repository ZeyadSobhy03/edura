import 'package:edura/core/error/app_error.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/home_work/new_homework_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_case/home_work/home_work_use_case.dart';

@injectable
class HomeWorkCubit extends Cubit<HomeWorkState> {
  final HomeWorkUseCase useCase;

  HomeWorkCubit({required this.useCase}) : super(HomeWorkInitial());

  Future<void> createHomework({
    String? lessonId,
    required NewHomeworkModel homework,
  }) async {
    emit(HomeWorkSubmitting());
    try {
      await useCase.createHomework(lessonId: lessonId, homework: homework);
      emit(CreateHomeworkSuccess(homework));
    } on AppError catch (error) {
      emit(CreateHomeworkFailure(error));
    } catch (e) {
      emit(CreateHomeworkFailure(const UnknownServerError()));
    }
  }

  Future<void> fetchHomeworks(String lessonId) async {
    emit(HomeWorkLoading());
    try {
      final homeworks = await useCase.getHomeworksByLesson(lessonId);
      emit(HomeWorkLoaded(homeworks));
    } on AppError catch (error) {
      emit(HomeWorkFailure(error));
    } catch (e) {
      emit(HomeWorkFailure(const UnknownServerError()));
    }
  }

  Future<void> publishHomework(String homeworkId) async {
    emit(HomeWorkSubmitting());
    try {
      await useCase.publishHomework(homeworkId);
      emit(PublishHomeworkSuccess());
    } on AppError catch (error) {
      emit(PublishHomeworkFailure(error));
    } catch (e) {
      emit(PublishHomeworkFailure(const UnknownServerError()));
    }
  }

  Future<void> deleteHomework(String homeworkId) async {
    emit(HomeWorkSubmitting());
    try {
      await useCase.deleteHomework(homeworkId);
      emit(DeleteHomeworkSuccess());
    } on AppError catch (error) {
      emit(DeleteHomeworkFailure(error));
    } catch (e) {
      emit(DeleteHomeworkFailure(const UnknownServerError()));
    }
  }

  Future<void> reviewHomework({
    required String submissionId,
    required int grade,
    required String feedback,
  }) async {
    emit(HomeWorkSubmitting());
    try {
      await useCase.reviewHomework(submissionId, grade, feedback);
      emit(ReviewHomeworkSuccess());
    } on AppError catch (error) {
      emit(ReviewHomeworkFailure(error));
    } catch (_) {
      emit(ReviewHomeworkFailure(const UnknownServerError()));
    }
  }
}

sealed class HomeWorkState {}

class HomeWorkInitial extends HomeWorkState {}

class HomeWorkLoading extends HomeWorkState {}

class HomeWorkSubmitting extends HomeWorkState {}

class HomeWorkLoaded extends HomeWorkState {
  final List<NewHomeworkModel> homeworks;

  HomeWorkLoaded(this.homeworks);
}

class CreateHomeworkSuccess extends HomeWorkState {
  final NewHomeworkModel homework;

  CreateHomeworkSuccess(this.homework);
}

class CreateHomeworkFailure extends HomeWorkState {
  final AppError error;

  CreateHomeworkFailure(this.error);
}

class PublishHomeworkSuccess extends HomeWorkState {}

class PublishHomeworkFailure extends HomeWorkState {
  final AppError error;

  PublishHomeworkFailure(this.error);
}

class DeleteHomeworkSuccess extends HomeWorkState {}

class DeleteHomeworkFailure extends HomeWorkState {
  final AppError error;

  DeleteHomeworkFailure(this.error);
}

class ReviewHomeworkSuccess extends HomeWorkState {}

class ReviewHomeworkFailure extends HomeWorkState {
  final AppError error;

  ReviewHomeworkFailure(this.error);
}

class HomeWorkFailure extends HomeWorkState {
  final AppError error;

  HomeWorkFailure(this.error);
}
