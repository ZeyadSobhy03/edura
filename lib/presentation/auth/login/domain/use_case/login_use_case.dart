import 'package:edura/presentation/auth/login/data/repositories/login_repositories.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginUseCase {
  final LoginRepositories loginRepositories;

  LoginUseCase({required this.loginRepositories});

  Future<User?> login(String email, String password) {
    return loginRepositories.login(email, password);
  }
  Future<User?> loginWithGoogle() {
    return loginRepositories.loginWithGoogle();
  }
}
