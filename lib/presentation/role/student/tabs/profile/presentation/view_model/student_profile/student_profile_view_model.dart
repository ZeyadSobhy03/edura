import 'package:edura/presentation/role/student/tabs/profile/domain/use_case/student_profile/student_profile_use_case.dart';
import 'package:edura/presentation/role/teacher/tabs/students/data/model/student_detail_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class StudentProfileCubit extends Cubit<StudentProfileState> {
  final StudentProfileUseCase studentProfileUseCase;

  StudentProfileCubit(this.studentProfileUseCase)
    : super(StudentProfileInitial());

  Future<void> getStudentProfile({required String studentId}) async {
    try {
      emit(StudentProfileLoading());
      final result = await studentProfileUseCase.getStudentProfile(
        studentId: studentId,
      );
      emit(StudentProfileLoaded(result));
    } catch (e) {
      emit(StudentProfileError(e.toString()));
    }
  }
}

sealed class StudentProfileState {}

class StudentProfileInitial extends StudentProfileState {}

class StudentProfileLoading extends StudentProfileState {}

class StudentProfileLoaded extends StudentProfileState {
  final StudentModel student;

  StudentProfileLoaded(this.student);
}

class StudentProfileError extends StudentProfileState {
  final String message;

  StudentProfileError(this.message);
}
