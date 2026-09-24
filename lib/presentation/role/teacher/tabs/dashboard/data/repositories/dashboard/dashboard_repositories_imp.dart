
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/data_source/dashboard/dashboard_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/dashboard/dashboard_stats.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/repositories/dashboard/dashboard_repositories.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DashboardRepositories)
class DashboardRepositoriesImp implements DashboardRepositories{

  final DashboardRemoteDataSource remoteDataSource;
  DashboardRepositoriesImp({required this.remoteDataSource});

  @override
  Future<DashboardStats> getDashboardStats() {
    return remoteDataSource.getDashboardStats();
  }


}