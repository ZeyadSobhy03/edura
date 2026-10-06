import '../../../../../../../../core/model/leaderboard_entry_model.dart';
import '../../../../../../../../core/model/teacher_option.dart';

abstract class LeaderboardRepositories {
  Future<List<TeacherOption>> fetchMyTeachers();
  Future<List<LeaderboardEntryModel>> fetchLeaderboard(String teacherId);
}