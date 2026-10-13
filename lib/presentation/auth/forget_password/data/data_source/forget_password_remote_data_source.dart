abstract class ForgetPasswordRemoteDataSource {
  Future<void> sendResetCode({required String email});

  Future<void> verifyResetCode({required String email, required String code});

  Future<void> updatePassword({required String newPassword});
}