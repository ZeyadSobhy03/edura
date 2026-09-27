import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/activities/recent_activity_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/repositories/activities/activities_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/activities/activities_remote_data_source.dart';
@LazySingleton(as: ActivitiesRepositories)
class ActivitiesRepositoriesImp implements ActivitiesRepositories {

  final ActivitiesRemoteDataSource remoteDataSource;
  ActivitiesRepositoriesImp({required this.remoteDataSource});

  @override
  Future<List<RecentActivityModel>> getRecentActivities({int limit = 10}) {
    return remoteDataSource.getRecentActivities(limit: limit);
  }


}