import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/data/data_source/class_schedules_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/data/model/class_schedules.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../../../core/error/app_error.dart';

@LazySingleton(as: ClassSchedulesRemoteDataSource)
class ClassSchedulesSupabaseDataSource
    implements ClassSchedulesRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<void> addSchedule({
    required String gradeId,
    required int dayOfWeek,
    required TimeOfDay start,
    required TimeOfDay end,
  }) async {
    try {
      await supabase.from('class_schedules').insert({
        'grade_id': gradeId,
        'day_of_week': dayOfWeek,
        'start_time': ClassSchedule.toDb(start),
        'end_time': ClassSchedule.toDb(end),
      });
    } catch (e) {
      throw ServerError();
    }
  }

  @override
  Future<void> deleteSchedule(String id) async {
    try {
      await supabase.from('class_schedules').delete().eq('id', id);
    } catch (e) {
      throw ServerError();
    }
  }

  @override
  Future<List<ClassSchedule>> getSchedules(String gradeId) async {
    try {
      final response = await supabase
          .from('class_schedules')
          .select()
          .eq('grade_id', gradeId)
          .order('day_of_week')
          .order('start_time');
      return response.map((j) => ClassSchedule.fromJson(j)).toList();
    } catch (e) {
      throw ServerError();
    }
  }
}
