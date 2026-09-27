import 'package:edura/presentation/role/teacher/tabs/dashboard/data/repositories/activities/activities_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/activities/recent_activity_model.dart';
@injectable
class ActivitiesUseCase {
  final ActivitiesRepositories activitiesRepositories;
  ActivitiesUseCase({required this.activitiesRepositories});
  Future<List<RecentActivityModel>> getRecentActivities({int limit = 10}){
    return activitiesRepositories.getRecentActivities(limit: limit);
  }


}