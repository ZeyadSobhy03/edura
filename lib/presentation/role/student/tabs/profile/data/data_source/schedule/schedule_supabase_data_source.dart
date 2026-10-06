import 'package:edura/presentation/role/student/tabs/profile/data/data_source/schedule/schedule_remote_data_source.dart';
import 'package:edura/presentation/role/student/tabs/profile/data/model/schedule/class_schedule_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: ScheduleRemoteDataSource)
class ScheduleSupabaseDataSource implements ScheduleRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<ClassScheduleModel>> fetchMySchedule() async {
    try {
      final rows = await supabase.rpc('get_my_schedule') as List;
      return rows
          .map<ClassScheduleModel>(
            (e) => ClassScheduleModel.fromJson(Map<String, dynamic>.from(e)),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch my schedule: $e');
    }
  }
}
