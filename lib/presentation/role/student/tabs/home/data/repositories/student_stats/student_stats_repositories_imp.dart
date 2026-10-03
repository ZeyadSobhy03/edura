

import 'package:edura/presentation/role/student/tabs/home/data/model/student_stats/student_stats.dart';
import 'package:edura/presentation/role/student/tabs/home/data/repositories/student_stats/student_stats_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/student_stats/student_stats_remote_data_source.dart';
@LazySingleton(as: StudentStatsRepositories)
class StudentStatsRepositoriesImp implements StudentStatsRepositories{
  final StudentStatsRemoteDataSource studentStatsRemoteDataSource;
  StudentStatsRepositoriesImp({required this.studentStatsRemoteDataSource});

  @override
  Future<StudentStatsModel> fetchStats({required String studentId}) {
    return studentStatsRemoteDataSource.fetchStats(studentId: studentId);
  }
}