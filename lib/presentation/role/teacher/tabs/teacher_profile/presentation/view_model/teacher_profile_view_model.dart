import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/teacher_profile_model.dart';
import '../../domain/use_case/teacher_profile_use_case.dart';

@injectable
class TeacherProfileCubit extends Cubit<TeacherProfileState> {
  final TeacherProfileUseCase teacherProfileUseCase;

  TeacherProfileCubit({required this.teacherProfileUseCase})
    : super(TeacherProfileInitial());

  Future<void> getTeacherProfile(String teacherId) async {
    emit(TeacherProfileLoading());
    try {
      final profile = await teacherProfileUseCase.getTeacherProfile(teacherId);
      emit(TeacherProfileLoaded(profile));
    } catch (e) {
      emit(TeacherProfileError(e.toString()));
    }
  }
}

sealed class TeacherProfileState {}

class TeacherProfileInitial extends TeacherProfileState {}

class TeacherProfileLoading extends TeacherProfileState {}

class TeacherProfileLoaded extends TeacherProfileState {
  final TeacherProfileModel profile;

  TeacherProfileLoaded(this.profile);
}

class TeacherProfileError extends TeacherProfileState {
  final String message;

  TeacherProfileError(this.message);
}
