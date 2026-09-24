import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/data/repositories/class_schedules_repositories.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/class_schedules.dart';

@injectable
class ClassSchedulesUseCase {
  final ClassSchedulesRepositories classSchedulesRepositories;

  ClassSchedulesUseCase({required this.classSchedulesRepositories});

  Future<List<ClassSchedule>> getSchedules(String gradeId) {
    return classSchedulesRepositories.getSchedules(gradeId);
  }

  Future<void> addSchedule({
    required String gradeId,
    required int dayOfWeek,
    required TimeOfDay start,
    required TimeOfDay end,
  }) {
    return classSchedulesRepositories.addSchedule(
      gradeId: gradeId,
      dayOfWeek: dayOfWeek,
      start: start,
      end: end,
    );
  }

  Future<void> deleteSchedule(String id) {
    return classSchedulesRepositories.deleteSchedule(id);
  }
}
