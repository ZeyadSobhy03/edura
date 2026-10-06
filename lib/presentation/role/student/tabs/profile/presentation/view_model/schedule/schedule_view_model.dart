import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/schedule/class_schedule_model.dart';
import '../../../domain/use_case/schedule/schedule_use_case.dart';

@injectable
class StudentScheduleCubit extends Cubit<StudentScheduleState> {
  final ScheduleUseCase scheduleUseCase;

  StudentScheduleCubit({required this.scheduleUseCase}) : super(StudentScheduleLoading());

  Future<void> load() async {
    emit(StudentScheduleLoading());
    try {
      final classes = await scheduleUseCase.fetchMySchedule();
      emit(StudentScheduleLoaded(classes));
    } catch (e) {
      emit(StudentScheduleError(e.toString()));
    }
  }
}

sealed class StudentScheduleState {}

class StudentScheduleLoading extends StudentScheduleState {}

class StudentScheduleLoaded extends StudentScheduleState {
  final List<ClassScheduleModel> classes;

  StudentScheduleLoaded(this.classes);
}

class StudentScheduleError extends StudentScheduleState {
  final String message;

  StudentScheduleError(this.message);
}
