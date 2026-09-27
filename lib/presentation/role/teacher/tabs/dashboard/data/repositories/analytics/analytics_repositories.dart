import '../../model/analytics/teacher_analytics_model.dart';

abstract class AnalyticsRepositories {
  Future<TeacherAnalytics> getAnalytics(String range);


}