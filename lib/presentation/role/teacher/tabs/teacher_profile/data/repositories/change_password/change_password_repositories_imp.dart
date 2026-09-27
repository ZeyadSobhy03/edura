import 'package:edura/presentation/role/teacher/tabs/teacher_profile/data/repositories/change_password/change_password_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/change_password/change_password_remote_data_source.dart';

@LazySingleton(as: ChangePasswordRepositories)
class ChangePasswordRepositoriesImp implements ChangePasswordRepositories {
  final ChangePasswordRemoteDataSource remoteDataSource;

  ChangePasswordRepositoriesImp({required this.remoteDataSource});

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) {
    return remoteDataSource.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
