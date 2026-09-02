import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LoginRepositories {

  Future<User?> login(String email, String password);
  Future<User?> loginWithGoogle();


}