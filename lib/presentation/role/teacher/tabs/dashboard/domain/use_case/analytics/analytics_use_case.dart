import 'package:edura/presentation/role/teacher/tabs/dashboard/data/repositories/analytics/analytics_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/analytics/teacher_analytics_model.dart';

@injectable
class AnalyticsUseCase {
  final AnalyticsRepositories analyticsRepositories;
  AnalyticsUseCase({required this.analyticsRepositories});
  Future<TeacherAnalytics> getAnalytics(String range){
    return analyticsRepositories.getAnalytics(range);
  }

}