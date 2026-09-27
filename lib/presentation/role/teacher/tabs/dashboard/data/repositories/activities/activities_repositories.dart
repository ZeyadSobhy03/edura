import '../../model/activities/recent_activity_model.dart';

abstract class ActivitiesRepositories {

  Future<List<RecentActivityModel>> getRecentActivities({int limit = 10});

}