import '../../model/dashboard/dashboard_stats.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardStats> getDashboardStats();
}
