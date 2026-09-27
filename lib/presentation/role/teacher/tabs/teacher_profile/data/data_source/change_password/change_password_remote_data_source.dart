abstract class ChangePasswordRemoteDataSource {
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
