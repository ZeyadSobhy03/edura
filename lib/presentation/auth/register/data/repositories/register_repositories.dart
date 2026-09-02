import '../model/register_request_model.dart';
import '../model/register_response_model.dart';

abstract class RegisterRepositories {

  Future<RegisterResponseModel> register({required RegisterRequestModel student});

}