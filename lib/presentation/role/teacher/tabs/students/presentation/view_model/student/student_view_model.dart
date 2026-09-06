import 'package:edura/core/error/app_error.dart';
import 'package:edura/presentation/role/teacher/tabs/students/domain/use_case/student/student_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/student_detail_model.dart';

class StudentCubit extends Cubit<StudentState> {
  final StudentUseCase studentUseCase;

  StudentCubit({
    required this.studentUseCase,
  }) : super(StudentInitial());

  Future<void> getStudents() async {
    emit(StudentLoading());

    try {
      final students = await studentUseCase.getStudents();

      emit(StudentLoaded(students));
    } on AppError catch (e) {
      emit(StudentError(e));
    } catch (e) {
      emit(StudentError(ServerError()));
    }
  }

  Future<void> getStudentDetails({
    required String studentId,
  }) async {
    emit(StudentDetailsLoading());

    try {
      final student = await studentUseCase.getStudentDetails(
        studentId: studentId,
      );

      emit(StudentDetailsLoaded(student));
    } on AppError catch (e) {
      emit(StudentError(e));
    } catch (e) {
      emit(StudentError(ServerError()));
    }
  }
}

sealed class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentLoaded extends StudentState {
  final List<StudentModel> students;

  StudentLoaded(this.students);
}

class StudentDetailsLoading extends StudentState {}

class StudentDetailsLoaded extends StudentState {
  final StudentModel student;

  StudentDetailsLoaded(this.student);
}

class StudentError extends StudentState {
  final AppError error;

  StudentError(this.error);
}




