import 'package:edura/core/error/app_error.dart';
import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/new_lesson_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/domain/use_case/teacher_lessons_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherLessonsCubit extends Cubit<TeacherLessonsState> {
  final TeacherLessonsUseCase teacherLessonsUseCase;

  TeacherLessonsCubit({required this.teacherLessonsUseCase}) : super(TeacherLessonsInitial());

  Future<void> createLesson(NewLessonModel lesson) async {
    emit(TeacherLessonsLoading());

    try {
      final response = await teacherLessonsUseCase.createLesson(lesson: lesson);
      final createdLesson = LessonModel.fromJson(response);
      emit(CreateLessonSuccess(createdLesson));
    } on AppError catch (error) {
      emit(CreateLessonFailure(error));
    } catch (_) {
      emit( CreateLessonFailure(UnknownServerError()));
    }
  }
}

sealed class TeacherLessonsState {}

class TeacherLessonsInitial extends TeacherLessonsState {}

class TeacherLessonsLoading extends TeacherLessonsState {}

class CreateLessonSuccess extends TeacherLessonsState {
  final LessonModel lesson;
  CreateLessonSuccess(this.lesson);
}

class CreateLessonFailure extends TeacherLessonsState {
  final AppError error;
   CreateLessonFailure(this.error);
}