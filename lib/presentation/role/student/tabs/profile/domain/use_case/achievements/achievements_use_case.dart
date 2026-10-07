import 'package:edura/presentation/role/student/tabs/profile/data/repositories/achievements/achievements_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/achievements/achievement_model.dart';

@injectable
class AchievementsUseCase {
  final AchievementsRepositories achievementsRepositories;

  AchievementsUseCase({required this.achievementsRepositories});

  Future<List<AchievementModel>> fetchAchievements() {
    return achievementsRepositories.fetchAchievements();
  }

  Future<({int points, int rank})> fetchPointsAndRank() {
    return achievementsRepositories.fetchPointsAndRank();
  }
}
