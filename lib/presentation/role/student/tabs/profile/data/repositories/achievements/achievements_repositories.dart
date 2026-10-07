import '../../model/achievements/achievement_model.dart';

abstract class AchievementsRepositories {
  Future<List<AchievementModel>> fetchAchievements();
  Future<({int points, int rank})> fetchPointsAndRank();
}