import 'dart:async';
import 'dart:io';

import 'package:edura/core/error/app_error.dart';
import 'package:edura/presentation/auth/login/data/data_source/remote/login_remote_data_source.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: LoginRemoteDataSource)
class LoginSupabaseDataSource implements LoginRemoteDataSource {
  final supabase = Supabase.instance.client;
  static const _googleScopes = ['email', 'profile'];

  AppError _mapAuthException(AuthException exception) {
    final text = exception.message.toLowerCase();
    final code = exception.code?.toLowerCase() ?? '';

    // Invalid email or password
    if (code == 'invalid_credentials' ||
        text.contains('invalid login credentials') ||
        text.contains('invalid_credentials') ||
        text.contains('invalid credentials')) {
      return const InvalidCredentialsError();
    }

    // Email is not confirmed
    if (code == 'email_not_confirmed' ||
        text.contains('email_not_confirmed') ||
        text.contains('email not confirmed')) {
      return const EmailNotConfirmedError();
    }

    // Too many login attempts
    if (code == 'over_request_rate_limit' ||
        text.contains('too many requests') ||
        text.contains('rate limit')) {
      return const TooManyRequestsError();
    }

    // Weak password
    if (code == 'weak_password' ||
        text.contains('weak password') ||
        text.contains('weak_password')) {
      return const WeakPasswordError();
    }

    // Email already registered
    if (text.contains('email already exists') ||
        text.contains('already registered') ||
        text.contains('user already registered')) {
      return const EmailAlreadyExistsError();
    }

    return const UnknownServerError();
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on AuthException catch (error) {
      throw _mapAuthException(error);
    } on GoogleSignInException {
      throw const UnknownServerError();
    } on SocketException {
      throw const NoInternetError();
    } on TimeoutException {
      throw const TimeoutError();
    } on PostgrestException {
      throw const ServerError();
    } on AppError {
      rethrow;
    } catch (error) {
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

      return response.user;
    });
  }
}
