import 'package:edura/presentation/role/teacher/tabs/teacher_profile/data/repositories/change_password/change_password_repositories.dart';
import 'package:injectable/injectable.dart';
@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepositories changePasswordRepositories;
  ChangePasswordUseCase({required this.changePasswordRepositories});
  Future<void> changePassword({required String oldPassword, required String newPassword}) {
    return changePasswordRepositories.changePassword(oldPassword: oldPassword, newPassword: newPassword);
  }

}