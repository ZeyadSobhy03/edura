import '../../data/model/register_request_model.dart';
import '../../data/model/register_response_model.dart';
import '../../data/repositories/register_repositories.dart';

class RegisterUseCase {
  final RegisterRepositories repositories;

  RegisterUseCase({required this.repositories});

  Future<RegisterResponseModel> register({
    required RegisterRequestModel student,
  }) {
    return repositories.register(student: student);
  }
}
