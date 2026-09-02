import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LoginRemoteDataSource {
  Future<User?> login(String email, String password);

  Future<User?> loginWithGoogle();
}
