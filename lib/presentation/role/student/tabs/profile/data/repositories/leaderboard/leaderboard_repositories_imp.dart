import 'package:edura/core/model/leaderboard_entry_model.dart';
import 'package:edura/core/model/teacher_option.dart';
import 'package:edura/presentation/role/student/tabs/profile/data/repositories/leaderboard/leaderboard_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/leaderboard/leaderboard_remote_data_source.dart';

@LazySingleton(as: LeaderboardRepositories)
class LeaderboardRepositoriesImp implements LeaderboardRepositories {
  final LeaderboardRemoteDataSource leaderboardRemoteDataSource;

  LeaderboardRepositoriesImp({required this.leaderboardRemoteDataSource});

  @override
  Future<List<LeaderboardEntryModel>> fetchLeaderboard(String teacherId) {
    return leaderboardRemoteDataSource.fetchLeaderboard(teacherId);
  }

  @override
  Future<List<TeacherOption>> fetchMyTeachers() {
    return leaderboardRemoteDataSource.fetchMyTeachers();
  }
}
