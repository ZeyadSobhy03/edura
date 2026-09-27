abstract class ChangePasswordRepositories {
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}