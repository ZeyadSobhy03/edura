import 'package:edura/core/error/app_error.dart';
import 'package:edura/presentation/auth/forget_password/domain/use_case/forget_password_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;

  ForgetPasswordCubit({required this.forgetPasswordUseCase})
      : super(ForgetPasswordInitial());

  Future<void> sendResetCode(String email) async {
    emit(ForgetPasswordLoading());
    try {
      await forgetPasswordUseCase.sendResetCode(email: email);
      if (isClosed) return;
      emit(ResetCodeSent(email));
    } on AppError catch (e) {
      if (isClosed) return;
      emit(ForgetPasswordFailure(e));
    } catch (_) {
      if (isClosed) return;
      emit(ForgetPasswordFailure(const UnknownServerError()));
    }
  }

  Future<void> verifyResetCode(String email, String code) async {
    emit(ForgetPasswordLoading());
    try {
      await forgetPasswordUseCase.verifyResetCode(email: email, code: code);
      if (isClosed) return;
      emit(ResetCodeVerified());
    } on AppError catch (e) {
      if (isClosed) return;
      emit(ForgetPasswordFailure(e));
    } catch (_) {
      if (isClosed) return;
      emit(ForgetPasswordFailure(const UnknownServerError()));
    }
  }

  Future<void> updatePassword(String newPassword) async {
    emit(ForgetPasswordLoading());
    try {
      await forgetPasswordUseCase.updatePassword(newPassword: newPassword);
      if (isClosed) return;
      emit(PasswordUpdated());
    } on AppError catch (e) {
      if (isClosed) return;
      emit(ForgetPasswordFailure(e));
    } catch (_) {
      if (isClosed) return;
      emit(ForgetPasswordFailure(const UnknownServerError()));
    }
  }
}

sealed class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ResetCodeSent extends ForgetPasswordState {
  final String email;
  ResetCodeSent(this.email);
}

class ResetCodeVerified extends ForgetPasswordState {}

class PasswordUpdated extends ForgetPasswordState {}

class ForgetPasswordFailure extends ForgetPasswordState {
  final AppError error;
  ForgetPasswordFailure(this.error);
}