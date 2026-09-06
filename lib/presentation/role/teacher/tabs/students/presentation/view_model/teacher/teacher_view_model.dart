import 'package:edura/core/error/app_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/model/teacher_model.dart';
import '../../../domain/use_case/teacher/teacher_use_case.dart';



class TeacherCubit extends Cubit<TeacherState> {
  final TeacherUseCase teacherUseCase;

  TeacherCubit({required this.teacherUseCase}) : super(TeacherInitial());

  Future<void> getTeachers() async {
    emit(TeacherLoading());
    try {
      final teachers = await teacherUseCase.getTeachers();
      emit(TeacherLoaded(teachers: teachers));
    } on AppError catch (e) {
      emit(TeacherError(error: e));
    }
  }
}

sealed class TeacherState {}

class TeacherInitial extends TeacherState {}

class TeacherLoading extends TeacherState {}

class TeacherLoaded extends TeacherState {
  final List<TeacherModel> teachers;
  TeacherLoaded({required this.teachers});
}

final class TeacherError extends TeacherState {
  final AppError error;
  TeacherError({required this.error});
}