import 'package:edura/core/error/app_error.dart';
import 'package:edura/core/error/app_errors.dart';
import 'package:edura/presentation/auth/login/data/data_source/local/login_hive_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/use_case/login_use_case.dart';


@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final LoginHiveDataSource _localDataSource = LoginHiveDataSource();

  LoginCubit({required this.loginUseCase}) : super(const LoginInitial());

  Future<void> login(
    String email,
    String password, {
    required String role,
  }) async {
    emit(const LoginLoading());
    try {
      final user = await loginUseCase.login(email, password);
      await _cacheSession(user, role: role);
      emit(LoginSuccess(user));
    } on AppError catch (error) {
      emit(LoginFailure(error));
    } catch (_) {
      emit(const LoginFailure(UnknownServerError()));
    }
  }

  Future<void> loginWithGoogle({required String role}) async {
    emit(const LoginWithGoogleLoading());
    try {
      final user = await loginUseCase.loginWithGoogle();
      await _cacheSession(user, role: role);
      emit(LoginWithGoogleSuccess(user));
    } on AppError catch (error) {
      emit(LoginWithGoogleFailure(error));
    } catch (_) {
      emit(LoginWithGoogleFailure(UnknownServerError()));
    }
  }

  Future<void> _cacheSession(User? user, {required String role}) async {
    final currentUser = user ?? Supabase.instance.client.auth.currentUser;
    if (currentUser == null) return;

    await _localDataSource.saveSession(
      userId: currentUser.id,
      role: role,
      email: currentUser.email,
    );
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
