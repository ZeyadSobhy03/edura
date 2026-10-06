import 'package:edura/core/model/leaderboard_entry_model.dart';
import 'package:edura/core/model/teacher_option.dart';
import 'package:edura/presentation/role/student/tabs/profile/data/data_source/leaderboard/leaderboard_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: LeaderboardRemoteDataSource)
class LeaderboardSupabaseDataSource implements LeaderboardRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<LeaderboardEntryModel>> fetchLeaderboard(String teacherId) async {
    try {
      final rows =
          await supabase.rpc(
                'get_leaderboard',
                params: {'p_teacher_id': teacherId},
              )
              as List;
      return rows
          .map<LeaderboardEntryModel>(
            (e) => LeaderboardEntryModel.fromJson(Map<String, dynamic>.from(e)),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch leaderboard: $e');
    }
  }

  @override
  Future<List<TeacherOption>> fetchMyTeachers() async {
    try {
      final links = await supabase
          .from('student_teachers')
          .select('teacher_id');
      final ids = links.map((e) => e['teacher_id'] as String).toList();
      if (ids.isEmpty) return [];
      final rows = await supabase
          .from('teacher')
          .select('id, name')
          .inFilter('id', ids);
      return rows
          .map<TeacherOption>(
            (e) =>
                TeacherOption(e['id'] as String, (e['name'] ?? '') as String),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch my teachers: $e');
    }
  }
}
