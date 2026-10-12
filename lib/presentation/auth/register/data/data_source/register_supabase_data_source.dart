import 'dart:developer';

import 'package:edura/core/error/app_error.dart';
import 'package:edura/core/error/rethrow_as_app_error.dart';
import 'package:edura/presentation/auth/register/data/data_source/register_remote_data_source.dart';
import 'package:edura/presentation/auth/register/data/model/register_request_model.dart';
import 'package:edura/presentation/auth/register/data/model/register_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: RegisterRemoteDataSource)
class RegisterSupabaseDataSource implements RegisterRemoteDataSource {
  final supabase = Supabase.instance.client;

  AppError _mapAuthException(AuthException exception) {
    final text = exception.message.toLowerCase();

    if (text.contains('weak password') || text.contains('weak_password')) {
      return const WeakPasswordError();
    }

    if (text.contains('email already exists') ||
        text.contains('already registered')) {
      return const EmailAlreadyExistsError();
    }

    if (text.contains('over_request_rate_limit') ||
        text.contains('too many requests') ||
        text.contains('rate limit')) {
      return const TooManyRequestsError();
    }

    // Default fallback for auth-related errors
    return const UnknownServerError();
  }

  @override
  Future<RegisterResponseModel> register({
    required RegisterRequestModel student,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: student.email,
        password: student.password,
        data: {
          'name': student.name,
          'grade': student.grade,
          'school': student.school,
          'phone': student.phone,
          'parent_phone': student.parentPhone,
        },
      );

      final user = response.user;

      if (user == null) {
        throw Exception('User registration failed');
      }

      await supabase.from('students').insert({
        'id': user.id,
        'name': student.name,
        'grade': student.grade,
        'school': student.school,
        'phone': student.phone,
        'parent_phone': student.parentPhone,
        'contact_email': student.email,
      });

      return RegisterResponseModel(
        id: user.id,
        email: user.email ?? student.email,
        name: student.name,
      );
    } on AuthException catch (e) {
      log('Supabase AuthException: ${e.message}');
      throw _mapAuthException(e);
    } catch (e) {
      log('Register error: $e');
      // Convert other exceptions into AppError variants so presentation layer
      // can localize user-friendly messages rather than raw backend text.
      rethrowAsAppError(e);
    }
  }
}
