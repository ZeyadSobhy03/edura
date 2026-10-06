
import 'package:edura/presentation/role/student/tabs/profile/data/repositories/leaderboard/leaderboard_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../core/model/leaderboard_entry_model.dart';
import '../../../../../../../../core/model/teacher_option.dart';
@injectable
class LeaderboardUseCase {
  final LeaderboardRepositories leaderboardRepositories;
  LeaderboardUseCase({required this.leaderboardRepositories});
  Future<List<TeacherOption>> fetchMyTeachers(){
    return leaderboardRepositories.fetchMyTeachers();
  }
  Future<List<LeaderboardEntryModel>> fetchLeaderboard(String teacherId){
    return leaderboardRepositories.fetchLeaderboard(teacherId);
  }
}