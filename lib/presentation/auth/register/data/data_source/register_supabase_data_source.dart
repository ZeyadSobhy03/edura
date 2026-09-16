import 'dart:developer';

import 'package:edura/presentation/auth/register/data/data_source/register_remote_data_source.dart';
import 'package:edura/presentation/auth/register/data/model/register_request_model.dart';
import 'package:edura/presentation/auth/register/data/model/register_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: RegisterRemoteDataSource)
class RegisterSupabaseDataSource implements RegisterRemoteDataSource {
  final supabase = Supabase.instance.client;

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
      throw Exception('AuthException: ${e.message}');
    } catch (e) {
      log('Register error: $e');
      throw Exception('Registration failed: $e');
    }
  }
}
