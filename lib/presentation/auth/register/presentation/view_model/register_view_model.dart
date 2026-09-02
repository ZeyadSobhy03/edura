import 'package:edura/presentation/auth/register/data/model/register_request_model.dart';
import 'package:edura/presentation/auth/register/data/model/register_response_model.dart';
import 'package:edura/presentation/auth/register/domain/use_case/register_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/app_error.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit({required this.registerUseCase}) : super(RegisterInitial());

  Future<void> register({required RegisterRequestModel student}) async {
    emit(RegisterLoading());
    try {
      final result = await registerUseCase.register(student: student);
      emit(RegisterSuccess(data: result));
    } on AppError catch (e) {
      emit(RegisterFailure(error: e));
    } catch (e) {
      emit(RegisterFailure(error: ServerError()));
    }
  }
}

sealed class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterResponseModel data;

  RegisterSuccess({required this.data});
}

class RegisterFailure extends RegisterState {
  final AppError error;

  RegisterFailure({required this.error});
}
