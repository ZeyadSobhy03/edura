
import 'package:edura/presentation/auth/log_out/data/repositories/log_out_repositories.dart';
import 'package:injectable/injectable.dart';
@injectable
class LogOutUseCase {
  final LogOutRepositories logOutRepositories;
  LogOutUseCase({required this.logOutRepositories});
  Future<void> logOut(){
    return logOutRepositories.logOut();
  }
}