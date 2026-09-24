import 'package:edura/presentation/role/teacher/tabs/dashboard/data/repositories/dashboard/dashboard_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/dashboard/dashboard_stats.dart';

@injectable
class DashboardUseCase {
  final DashboardRepositories dashboardRepositories;

  DashboardUseCase({required this.dashboardRepositories});

  Future<DashboardStats> getDashboardStats() {
    return dashboardRepositories.getDashboardStats();
  }
}
