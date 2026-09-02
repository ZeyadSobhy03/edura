import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:edura/core/error/app_error.dart';
import 'package:edura/presentation/auth/login/data/data_source/remote/login_remote_data_source.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginSupabaseDataSource implements LoginRemoteDataSource {
  final supabase = Supabase.instance.client;
  static const _googleScopes = ['email', 'profile'];

  AppError _mapAuthException(AuthException exception) {
    final text = exception.message.toLowerCase();

    if (text.contains('invalid_credentials') ||
        text.contains('invalid credentials')) {
      return const InvalidCredentialsError();
    }

    if (text.contains('email_not_confirmed') ||
        text.contains('email not confirmed')) {
      return const EmailNotConfirmedError();
    }

    if (text.contains('over_request_rate_limit') ||
        text.contains('too many requests') ||
        text.contains('rate limit')) {
      return const TooManyRequestsError();
    }

    if (text.contains('weak password') || text.contains('weak_password')) {
      return const WeakPasswordError();
    }

    if (text.contains('email already exists') ||
        text.contains('already registered')) {
      return const EmailAlreadyExistsError();
    }

    return const UnknownServerError();
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on AuthException catch (error, stackTrace) {
      log(
        'Supabase AuthException',
        error: error,
        stackTrace: stackTrace,
      );

      log('message: ${error.message}');
      log('statusCode: ${error.statusCode}');
      log('code: ${error.code}');

      throw _mapAuthException(error);
    } on GoogleSignInException catch (error, stackTrace) {
      log(
        'Google Sign-In Exception',
        error: error,
        stackTrace: stackTrace,
      );

      throw const UnknownServerError();
    } on SocketException catch (error, stackTrace) {
      log(
        'SocketException: $error',
        stackTrace: stackTrace,
      );

      throw const NoInternetError();
    } on TimeoutException catch (error, stackTrace) {
      log(
        'TimeoutException: $error',
        stackTrace: stackTrace,
      );

      throw const TimeoutError();
    } on PostgrestException catch (error, stackTrace) {
      log(
        'PostgrestException',
        error: error,
        stackTrace: stackTrace,
      );

      throw const ServerError();
    } on AppError {
      rethrow;
    } catch (error, stackTrace) {
      log(
        'Unknown Exception',
        error: error,
        stackTrace: stackTrace,
      );

      throw const UnknownServerError();
    }
  }
  @override
  Future<User?> login(String email, String password) {
    return _guard(() async {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user;
    });
  }

  @override
  Future<User?> loginWithGoogle() {
    return _guard(() async {
      final googleSignIn = GoogleSignIn.instance;
      GoogleSignInAccount? googleUser = await googleSignIn
          .attemptLightweightAuthentication();
      googleUser ??= await googleSignIn.authenticate();

      final authorization =
          await googleUser.authorizationClient.authorizationForScopes(
            _googleScopes,
          ) ??
          await googleUser.authorizationClient.authorizeScopes(_googleScopes);

      final idToken = googleUser.authentication.idToken;
      if (idToken == null) {
        throw const UnknownServerError();
      }

      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );


      log('Login with Google response: ${response}');

      return response.user;
    });
  }
}
