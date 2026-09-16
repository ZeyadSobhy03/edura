import 'package:edura/presentation/auth/register/data/model/register_request_model.dart';
import 'package:edura/presentation/auth/register/data/model/register_response_model.dart';
import 'package:edura/presentation/auth/register/data/repositories/register_repositories.dart';
import 'package:injectable/injectable.dart';

import '../data_source/register_remote_data_source.dart';


@LazySingleton(as: RegisterRepositories)
class RegisterRepositoriesImp implements RegisterRepositories {
  final RegisterRemoteDataSource remoteDataSource;
  RegisterRepositoriesImp({required this.remoteDataSource});

  @override
  Future<RegisterResponseModel> register({required RegisterRequestModel student}) {
    return remoteDataSource.register(student: student);
  }


}