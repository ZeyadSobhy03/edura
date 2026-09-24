import 'package:flutter/material.dart';

import '../model/class_schedules.dart';

abstract class ClassSchedulesRepositories {
  Future<List<ClassSchedule>> getSchedules(String gradeId);

  Future<void> addSchedule({
    required String gradeId,
    required int dayOfWeek,
    required TimeOfDay start,
    required TimeOfDay end,
  });

  Future<void> deleteSchedule(String id);
}
