import 'package:edura/presentation/role/student/tabs/profile/data/model/achievements/achievement_model.dart';
import 'package:edura/presentation/role/student/tabs/profile/data/data_source/achievements/achievements_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AchievementsRemoteDataSource)
class AchievementsSupabaseDataSource implements AchievementsRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<AchievementModel>> fetchAchievements() async {
    try {
      final rows = await supabase.rpc('get_my_achievements') as List;
      return rows
          .map<AchievementModel>(
            (e) => AchievementModel.fromJson(Map<String, dynamic>.from(e)),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch achievements: $e');
    }
  }

  @override
  Future<({int points, int rank})> fetchPointsAndRank() async {
    try {
      final rows = await supabase.rpc('get_my_stats') as List;
      if (rows.isEmpty) return (points: 0, rank: 0);
      final r = Map<String, dynamic>.from(rows.first as Map);
      return (
        points: (r['points'] as num?)?.toInt() ?? 0,
        rank: (r['rank'] as num?)?.toInt() ?? 0,
      );
    } catch (e) {
      throw Exception('Failed to fetch points and rank: $e');
    }
  }
}
