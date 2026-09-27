import 'package:edura/presentation/role/teacher/tabs/teacher_profile/data/data_source/change_password/change_password_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: ChangePasswordRemoteDataSource)
class ChangePasswordSupabaseDataSource implements ChangePasswordRemoteDataSource {

  final supabase = Supabase.instance.client;

  @override
  Future<void> changePassword({required String oldPassword, required String newPassword})async {
    try {
      final response = await supabase.auth.updateUser(
        UserAttributes(
          password: newPassword,
        ),
      );
      if (response.user == null) {
        throw Exception('Failed to change password');
      }
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }

}