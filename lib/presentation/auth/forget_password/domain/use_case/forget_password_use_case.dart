import 'package:edura/presentation/auth/forget_password/data/repositories/forget_password_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepositories forgetPasswordRepositories;
  ForgetPasswordUseCase({required this.forgetPasswordRepositories});
  Future<void> sendResetCode({required String email}){
    return forgetPasswordRepositories.sendResetCode(email: email);
  }

  Future<void> verifyResetCode({required String email, required String code}){
    return forgetPasswordRepositories.verifyResetCode(email: email, code: code);
  }

  Future<void> updatePassword({required String newPassword}){
    return forgetPasswordRepositories.updatePassword(newPassword: newPassword);
  }
}