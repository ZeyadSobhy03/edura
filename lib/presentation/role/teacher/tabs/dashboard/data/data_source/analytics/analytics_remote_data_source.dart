
import '../../model/analytics/teacher_analytics_model.dart';

abstract class AnalyticsRemoteDataSource {
  Future<TeacherAnalytics> getAnalytics(String range);
}