import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_case/change_password/change_password_use_case.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordCubit({required this.changePasswordUseCase})
      : super(ChangePasswordInitial());

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoading());
    try {
      await changePasswordUseCase.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      emit(ChangePasswordSuccess());
    } catch (e) {
      emit(ChangePasswordError(e.toString()));
    }
  }
}

sealed class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}

class ChangePasswordError extends ChangePasswordState {
  final String message;

  ChangePasswordError(this.message);
}