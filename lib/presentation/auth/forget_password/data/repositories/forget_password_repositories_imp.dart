import 'package:edura/presentation/auth/forget_password/data/repositories/forget_password_repositories.dart';
import 'package:injectable/injectable.dart';

import '../data_source/forget_password_remote_data_source.dart';
@LazySingleton(as: ForgetPasswordRepositories)
class ForgetPasswordRepositoriesImp implements  ForgetPasswordRepositories{
  final ForgetPasswordRemoteDataSource forgetPasswordRemoteDataSource;
  ForgetPasswordRepositoriesImp({required this.forgetPasswordRemoteDataSource});

  @override
  Future<void> sendResetCode({required String email}) {
    return forgetPasswordRemoteDataSource.sendResetCode(email: email);
  }

  @override
  Future<void> updatePassword({required String newPassword}) {
    return forgetPasswordRemoteDataSource.updatePassword(newPassword: newPassword);
  }

  @override
  Future<void> verifyResetCode({required String email, required String code}) {
    return forgetPasswordRemoteDataSource.verifyResetCode(email: email, code: code);
  }



}