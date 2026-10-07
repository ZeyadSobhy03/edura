
import '../../model/achievements/achievement_model.dart';

abstract class AchievementsRemoteDataSource {
  Future<List<AchievementModel>> fetchAchievements();
  Future<({int points, int rank})> fetchPointsAndRank();
}

