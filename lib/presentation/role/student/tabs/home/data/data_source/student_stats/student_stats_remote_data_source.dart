import '../../model/student_stats/student_stats.dart';

abstract class StudentStatsRemoteDataSource {
  Future<StudentStatsModel> fetchStats({required String studentId});
}
