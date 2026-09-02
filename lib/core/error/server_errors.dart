part of 'app_error.dart';

class ServerError extends AppError {
  const ServerError();
}

class ServiceUnavailableError extends AppError {
  const ServiceUnavailableError();
}

class UnknownServerError extends AppError {
  const UnknownServerError();
}
