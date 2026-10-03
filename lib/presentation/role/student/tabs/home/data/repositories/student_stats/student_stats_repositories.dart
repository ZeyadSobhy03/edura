import '../../model/student_stats/student_stats.dart';

abstract class StudentStatsRepositories {
  Future<StudentStatsModel> fetchStats({required String studentId});
}
