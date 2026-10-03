import 'package:edura/presentation/role/student/tabs/lessons/data/model/lesson_progress/lesson_progress.dart';
import 'package:edura/presentation/role/student/tabs/lessons/domain/use_case/lesson_progress/lesson_progress_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LessonProgressCubit extends Cubit<LessonProgressState> {
  final LessonProgressUseCase lessonProgressUseCase;

  final Map<String, LessonProgressModel> progressMap = {};

  LessonProgressCubit({
    required this.lessonProgressUseCase,
  }) : super(LessonProgressInitial());

  Future<void> fetchLessonProgress(
      String lessonId,
      String studentId,
      ) async {
    emit(LessonProgressLoading(lessonId));

    try {
      final progress = await lessonProgressUseCase.getLessonProgress(
        lessonId,
        studentId,
      );

      if (progress == null) {
        emit(LessonProgressNotFound(lessonId));
      } else {
        progressMap[lessonId] = progress;

        emit(
          LessonProgressLoaded(
            lessonId: lessonId,
            progress: progress,
          ),
        );
      }
    } catch (e) {
      emit(
        LessonProgressFailure(
          lessonId: lessonId,
          error: e.toString(),
        ),
      );
    }
  }

  Future<LessonProgressModel?> getProgress(
      String lessonId,
      String studentId,
      ) async {
    return lessonProgressUseCase.getLessonProgress(
      lessonId,
      studentId,
    );
  }

  Future<void> createLessonProgress(
      LessonProgressModel progress,
      ) async {
    try {
      await lessonProgressUseCase.createLessonProgress(
        progress: progress,
      );

      progressMap[progress.lessonId] = progress;

      emit(
        LessonProgressLoaded(
          lessonId: progress.lessonId,
          progress: progress,
        ),
      );
    } catch (e) {
      emit(
        LessonProgressFailure(
          lessonId: progress.lessonId,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> updateLessonProgress(
      LessonProgressModel progress,
      ) async {
    try {
      await lessonProgressUseCase.updateLessonProgress(
        progress: progress,
      );

      progressMap[progress.lessonId] = progress;

      emit(
        LessonProgressLoaded(
          lessonId: progress.lessonId,
          progress: progress,
        ),
      );
    } catch (e) {
      emit(
        LessonProgressFailure(
          lessonId: progress.lessonId,
          error: e.toString(),
        ),
      );
    }
  }
}

sealed class LessonProgressState {}

class LessonProgressInitial extends LessonProgressState {}

class LessonProgressLoading extends LessonProgressState {
  final String lessonId;

  LessonProgressLoading(this.lessonId);
}

class LessonProgressNotFound extends LessonProgressState {
  final String lessonId;

  LessonProgressNotFound(this.lessonId);
}

class LessonProgressLoaded extends LessonProgressState {
  final String lessonId;
  final LessonProgressModel progress;

  LessonProgressLoaded({
    required this.lessonId,
    required this.progress,
  });
}

class LessonProgressFailure extends LessonProgressState {
  final String lessonId;
  final String error;

  LessonProgressFailure({
    required this.lessonId,
    required this.error,
  });
}