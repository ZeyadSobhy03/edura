import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:edura/presentation/auth/login/data/data_source/local/login_hive_data_source.dart';
import '../../domain/use_case/log_out_use_case.dart';

@injectable
class LogOutCubit extends Cubit<LogOutState> {
  final LogOutUseCase logOutUseCase;
  final LoginHiveDataSource _localDataSource = LoginHiveDataSource();

  LogOutCubit({required this.logOutUseCase}) : super(LogOutInitial());

  Future<void> logOut() async {
    emit(LogOutLoading());
    try {
      await logOutUseCase.logOut();
      await _localDataSource.clearSession();
      emit(LogOutSuccess());
    } catch (e) {
      emit(LogOutFailure(message: e.toString()));
    }
  }
}

sealed class LogOutState {}

class LogOutInitial extends LogOutState {}

class LogOutLoading extends LogOutState {}

class LogOutSuccess extends LogOutState {}

class LogOutFailure extends LogOutState {
  final String message;

  LogOutFailure({required this.message});
}
