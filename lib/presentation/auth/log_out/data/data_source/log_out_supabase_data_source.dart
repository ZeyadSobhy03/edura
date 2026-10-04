import 'package:edura/presentation/auth/log_out/data/data_source/log_out_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: LogOutRemoteDataSource)
class LogOutSupabaseDataSource implements LogOutRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<void> logOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      throw Exception('Failed to log out: $e');
    }
  }
}
