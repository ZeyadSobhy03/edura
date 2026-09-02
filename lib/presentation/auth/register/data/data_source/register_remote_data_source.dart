import 'package:edura/presentation/auth/register/data/model/register_request_model.dart';
import 'package:edura/presentation/auth/register/data/model/register_response_model.dart';

abstract class RegisterRemoteDataSource {
  Future<RegisterResponseModel> register({required RegisterRequestModel student});
}
