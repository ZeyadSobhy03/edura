
import 'package:edura/presentation/role/student/tabs/profile/data/model/achievements/achievement_model.dart';
import 'package:edura/presentation/role/student/tabs/profile/data/repositories/achievements/achievements_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/achievements/achievements_remote_data_source.dart';

@LazySingleton(as: AchievementsRepositories)
class AchievementsRepositoriesImp implements AchievementsRepositories  {
  final AchievementsRemoteDataSource achievementsRemoteDataSource;
  AchievementsRepositoriesImp({required this.achievementsRemoteDataSource});

  @override
  Future<List<AchievementModel>> fetchAchievements() {
    return achievementsRemoteDataSource.fetchAchievements();

  }

  @override
  Future<({int points, int rank})> fetchPointsAndRank() {
    return achievementsRemoteDataSource.fetchPointsAndRank();
  }
}