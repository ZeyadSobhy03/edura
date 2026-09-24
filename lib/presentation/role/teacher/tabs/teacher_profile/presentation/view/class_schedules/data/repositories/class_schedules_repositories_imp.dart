import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/data/model/class_schedules.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/data/repositories/class_schedules_repositories.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../data_source/class_schedules_remote_data_source.dart';

@LazySingleton(as: ClassSchedulesRepositories)
class ClassSchedulesRepositoriesImp implements ClassSchedulesRepositories {
  final ClassSchedulesRemoteDataSource remoteDataSource;

  ClassSchedulesRepositoriesImp({required this.remoteDataSource});

  @override
  Future<void> addSchedule({
    required String gradeId,
    required int dayOfWeek,
    required TimeOfDay start,
    required TimeOfDay end,
  }) {
    return remoteDataSource.addSchedule(
      gradeId: gradeId,
      dayOfWeek: dayOfWeek,
      start: start,
      end: end,
    );
  }

  @override
  Future<void> deleteSchedule(String id) {
    return remoteDataSource.deleteSchedule(id);
  }

  @override
  Future<List<ClassSchedule>> getSchedules(String gradeId) {
    return remoteDataSource.getSchedules(gradeId);
  }
}
