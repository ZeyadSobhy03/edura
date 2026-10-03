import 'package:edura/presentation/role/student/tabs/home/data/repositories/student_stats/student_stats_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/student_stats/student_stats.dart';

@injectable
class StudentStatsUseCase {
  final StudentStatsRepositories studentStatsRepositories;

  StudentStatsUseCase({required this.studentStatsRepositories});

  Future<StudentStatsModel> fetchStats({required String studentId}) {
    return studentStatsRepositories.fetchStats(studentId: studentId);
  }
}
