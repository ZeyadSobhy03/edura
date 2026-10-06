import '../../../../../../../../core/model/leaderboard_entry_model.dart';
import '../../../../../../../../core/model/teacher_option.dart';

abstract class LeaderboardRemoteDataSource {
  Future<List<TeacherOption>> fetchMyTeachers();
  Future<List<LeaderboardEntryModel>> fetchLeaderboard(String teacherId);
}