part of 'app_error.dart';

class InvalidEmailError extends AppError {
  const InvalidEmailError();
}

class EmptyFieldError extends AppError {
  const EmptyFieldError();
}

class PasswordTooShortError extends AppError {
  const PasswordTooShortError();
}

class PasswordMismatchError extends AppError {
  const PasswordMismatchError();
}
