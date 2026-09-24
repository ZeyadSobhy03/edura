import '../../model/dashboard/dashboard_stats.dart';

abstract class DashboardRepositories {
  Future<DashboardStats> getDashboardStats();
}