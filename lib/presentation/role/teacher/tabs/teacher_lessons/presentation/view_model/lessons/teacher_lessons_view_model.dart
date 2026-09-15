import 'package:edura/core/error/app_error.dart';
import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/lessons/new_lesson_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/domain/use_case/lessons/teacher_lessons_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherLessonsCubit extends Cubit<TeacherLessonsState> {
  final TeacherLessonsUseCase teacherLessonsUseCase;

  TeacherLessonsCubit({required this.teacherLessonsUseCase})
      : super(TeacherLessonsInitial());

  Future<void> fetchLessons() async {
    emit(TeacherLessonsLoading());

    try {
      final lessons = await teacherLessonsUseCase.getLessons();
      emit(_loadedStateFrom(lessons));
    } on AppError catch (error) {
      emit(TeacherLessonsFailure(error));
    } catch (_) {
      emit(TeacherLessonsFailure(const UnknownServerError()));
    }
  }

  Future<void> createLesson(NewLessonModel lesson) async {
    emit(TeacherLessonsSubmitting());

    try {
      final response = await teacherLessonsUseCase.createLesson(lesson: lesson);
      emit(CreateLessonSuccess(LessonModel.fromJson(response)));
    } on AppError catch (error) {
      emit(CreateLessonFailure(error));
    } catch (_) {
      emit(CreateLessonFailure(const UnknownServerError()));
    }
  }

  Future<void> updateLesson({
    required String lessonId,
    required NewLessonModel lesson,
    String? currentVideoUrl,
    String? currentPdfUrl,
  }) async {
    emit(TeacherLessonsSubmitting());

    try {
      final response = await teacherLessonsUseCase.updateLesson(
        lessonId: lessonId,
        lesson: lesson,
        currentVideoUrl: currentVideoUrl,
        currentPdfUrl: currentPdfUrl,
      );
      emit(UpdateLessonSuccess(LessonModel.fromJson(response)));
    } on AppError catch (error) {
      emit(UpdateLessonFailure(error));
    } catch (_) {
      emit(UpdateLessonFailure(const UnknownServerError()));
    }
  }

  Future<void> publishLesson(LessonModel lesson) async {
    await updateLesson(
      lessonId: lesson.id,
      lesson: NewLessonModel(
        title: lesson.title,
        durationMinutes: lesson.durationMinutes,
        subject: lesson.subject,
        description: lesson.overviewDescription,
        isPublished: true,
      ),
      currentVideoUrl: lesson.videoUrl,
      currentPdfUrl: lesson.pdfUrl,
    );
  }

  Future<void> deleteLesson(String lessonId) async {
    emit(TeacherLessonsSubmitting());

    try {
      await teacherLessonsUseCase.deleteLesson(lessonId: lessonId);
      emit(DeleteLessonSuccess(lessonId));
    } on AppError catch (error) {
      emit(DeleteLessonFailure(error));
    } catch (_) {
      emit(DeleteLessonFailure(const UnknownServerError()));
    }
  }

  TeacherLessonsLoaded _loadedStateFrom(List<LessonModel> lessons) {
    return TeacherLessonsLoaded(
      publishedLessons: lessons.where((lesson) => lesson.isPublished).toList(),
      draftLessons: lessons.where((lesson) => !lesson.isPublished).toList(),
    );
  }
}

sealed class TeacherLessonsState {}

class TeacherLessonsInitial extends TeacherLessonsState {}

class TeacherLessonsLoading extends TeacherLessonsState {}

class TeacherLessonsSubmitting extends TeacherLessonsState {}

class TeacherLessonsLoaded extends TeacherLessonsState {
  final List<LessonModel> publishedLessons;
  final List<LessonModel> draftLessons;

  TeacherLessonsLoaded({
    required this.publishedLessons,
    required this.draftLessons,
  });
}

class TeacherLessonsFailure extends TeacherLessonsState {
  final AppError error;

  TeacherLessonsFailure(this.error);
}

class CreateLessonSuccess extends TeacherLessonsState {
  final LessonModel lesson;

  CreateLessonSuccess(this.lesson);
}

class CreateLessonFailure extends TeacherLessonsState {
  final AppError error;

  CreateLessonFailure(this.error);
}

class UpdateLessonSuccess extends TeacherLessonsState {
  final LessonModel lesson;

  UpdateLessonSuccess(this.lesson);
}

class UpdateLessonFailure extends TeacherLessonsState {
  final AppError error;

  UpdateLessonFailure(this.error);
}

class DeleteLessonSuccess extends TeacherLessonsState {
  final String lessonId;

  DeleteLessonSuccess(this.lessonId);
}

class DeleteLessonFailure extends TeacherLessonsState {
  final AppError error;

  DeleteLessonFailure(this.error);
}
