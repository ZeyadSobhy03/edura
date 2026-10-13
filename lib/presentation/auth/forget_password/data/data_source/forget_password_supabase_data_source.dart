import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/error/rethrow_as_app_error.dart';
import 'forget_password_remote_data_source.dart';

@LazySingleton(as: ForgetPasswordRemoteDataSource)
class ForgetPasswordSupabaseDataSource
    implements ForgetPasswordRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<void> sendResetCode({required String email}) async {
    try {
      await supabase.auth.resetPasswordForEmail(email.trim());
    } catch (e) {
      debugPrint('Error sending reset code: $e');
      rethrowAsAppError(e);
    }
  }

  @override
  Future<void> verifyResetCode({
    required String email,
    required String code,
  }) async {
    try {
      await supabase.auth.verifyOTP(
        email: email.trim(),
        token: code.trim(),
        type: OtpType.recovery,
      );
    } catch (e) {
      debugPrint('Error verifying reset code: $e');

      rethrowAsAppError(e);
    }
  }

  @override
  Future<void> updatePassword({required String newPassword}) async {
    try {
      await supabase.auth.updateUser(UserAttributes(password: newPassword));
      await supabase.auth.signOut();
    } catch (e) {
      debugPrint('Error updating password: $e');
      rethrowAsAppError(e);
    }
  }
}