import 'package:edura/core/error/app_error.dart';
import 'package:edura/core/error/app_errors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/use_case/login_use_case.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(const LoginInitial());

  Future<void> login(String email, String password) async {
    emit(const LoginLoading());
    try {
      final user = await loginUseCase.login(email, password);
      emit(LoginSuccess(user));
    } on AppError catch (error) {
      emit(LoginFailure(error));
    } catch (_) {
      emit(const LoginFailure(UnknownServerError()));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(const LoginWithGoogleLoading());
    try {
      final user = await loginUseCase.loginWithGoogle();
      emit(LoginWithGoogleSuccess(user));
    } on AppError catch (error) {
      emit(LoginWithGoogleFailure(error));
    } catch (_) {
      emit(LoginWithGoogleFailure(UnknownServerError()));
    }
  }
}

sealed class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final User? user;

  const LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  final AppError error;

  const LoginFailure(this.error);
}

class LoginWithGoogleLoading extends LoginState {
  const LoginWithGoogleLoading();
}

class LoginWithGoogleSuccess extends LoginState {
  final User? user;

  const LoginWithGoogleSuccess(this.user);
}

class LoginWithGoogleFailure extends LoginState {
  final AppError error;

  LoginWithGoogleFailure(this.error);
}
