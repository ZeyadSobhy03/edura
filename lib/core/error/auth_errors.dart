part of 'app_error.dart';

class InvalidCredentialsError extends AppError {
  const InvalidCredentialsError();
}

class EmailNotConfirmedError extends AppError {
  const EmailNotConfirmedError();
}

class EmailAlreadyExistsError extends AppError {
  const EmailAlreadyExistsError();
}

class WeakPasswordError extends AppError {
  const WeakPasswordError();
}

class TooManyRequestsError extends AppError {
  const TooManyRequestsError();
}
class UserNotFoundError extends AppError {
  const UserNotFoundError();
}
class WrongPasswordError extends AppError {
  const WrongPasswordError();
}


class SessionExpiredError extends AppError {
  const SessionExpiredError();
}
