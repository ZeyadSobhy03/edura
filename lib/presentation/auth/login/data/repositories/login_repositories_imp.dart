import 'package:edura/presentation/auth/login/data/data_source/remote/login_remote_data_source.dart';
import 'package:edura/presentation/auth/login/data/repositories/login_repositories.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginRepositoriesImp implements LoginRepositories {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoriesImp({required this.remoteDataSource});

  @override
  Future<User?> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  @override
  Future<User?> loginWithGoogle() {
    return remoteDataSource.loginWithGoogle();
  }
}
