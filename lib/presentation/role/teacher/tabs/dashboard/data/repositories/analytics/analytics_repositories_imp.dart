import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/analytics/teacher_analytics_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/repositories/analytics/analytics_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/analytics/analytics_remote_data_source.dart';


@LazySingleton(as: AnalyticsRepositories)
class AnalyticsRepositoriesImp implements AnalyticsRepositories{
  final AnalyticsRemoteDataSource remoteDataSource;
  AnalyticsRepositoriesImp({required this.remoteDataSource});

  @override
  Future<TeacherAnalytics> getAnalytics(String range) {
    return remoteDataSource.getAnalytics(range);
  }


}