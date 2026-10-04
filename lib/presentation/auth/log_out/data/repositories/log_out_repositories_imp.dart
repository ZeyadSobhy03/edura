import 'package:injectable/injectable.dart';

import '../data_source/log_out_remote_data_source.dart';
import 'log_out_repositories.dart';
@LazySingleton(as: LogOutRepositories)
class LogOutRepositoriesImp  implements LogOutRepositories{
  final LogOutRemoteDataSource logOutRemoteDataSource;
  LogOutRepositoriesImp({required this.logOutRemoteDataSource});

  @override
  Future<void> logOut() {
    return logOutRemoteDataSource.logOut();
  }
}