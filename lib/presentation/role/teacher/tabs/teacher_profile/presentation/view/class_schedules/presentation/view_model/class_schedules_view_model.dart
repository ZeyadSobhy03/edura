import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/domain/use_case/class_schedules_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/class_schedules.dart';

@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  final ClassSchedulesUseCase classSchedulesUseCase;

  ScheduleCubit({required this.classSchedulesUseCase})
    : super(ScheduleInitial());

  Future<void> load(String gradeId) async {
    emit(ScheduleLoading());
    try {
      emit(ScheduleLoaded(await classSchedulesUseCase.getSchedules(gradeId)));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }

  Future<void> add({
    required String gradeId,
    required int dayOfWeek,
    required TimeOfDay start,
    required TimeOfDay end,
  }) async {
    try {
      await classSchedulesUseCase.addSchedule(
        gradeId: gradeId,
        dayOfWeek: dayOfWeek,
        start: start,
        end: end,
      );
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
    await load(gradeId);
  }

  Future<void> delete({required String id, required String gradeId}) async {
    try {
      await classSchedulesUseCase.deleteSchedule(id);
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
    await load(gradeId);
  }
}

sealed class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<ClassSchedule> schedules;

  ScheduleLoaded(this.schedules);
}

class ScheduleError extends ScheduleState {
  final String message;

  ScheduleError(this.message);
}
