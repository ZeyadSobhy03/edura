import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

import '../error/app_error.dart';

class ErrorMessages {
  static String get(BuildContext context, AppError error) {
    final l10n = AppLocalizations.of(context)!;

    return switch (error) {
      InvalidCredentialsError() => l10n.invalidCredentials,
      EmailNotConfirmedError() => l10n.emailNotConfirmed,
      EmailAlreadyExistsError() => l10n.emailAlreadyExists,
      WeakPasswordError() => l10n.weakPassword,
      TooManyRequestsError() => l10n.tooManyRequests,
      SessionExpiredError() => l10n.sessionExpired,
      NetworkError() => l10n.networkError,
      NoInternetError() => l10n.noInternet,
      TimeoutError() => l10n.timeoutError,
      ServerError() => l10n.serverError,
      ServiceUnavailableError() => l10n.serviceUnavailable,
      UnknownServerError() => l10n.unknownServerError,
      InvalidEmailError() => l10n.invalidEmail,
      EmptyFieldError() => l10n.emptyField,
      PasswordTooShortError() => l10n.passwordTooShort,
      WrongPasswordError() => l10n.wrongPassword,
      UserNotFoundError() => l10n.userNotFound,
      PasswordMismatchError() => l10n.passwordMismatch,
      UnauthorizedError() => l10n.unauthorized,
    };
  }
}
