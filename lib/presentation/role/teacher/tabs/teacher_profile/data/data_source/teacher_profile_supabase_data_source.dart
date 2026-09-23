import 'dart:developer';

import 'package:edura/presentation/role/teacher/tabs/teacher_profile/data/data_source/teacher_profile_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/data/model/teacher_profile_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/error/app_error.dart';

@LazySingleton(as: TeacherProfileRemoteDataSource)
class TeacherProfileSupabaseDataSource
    implements TeacherProfileRemoteDataSource {
  final supabse = Supabase.instance.client;

  @override
  Future<TeacherProfileModel> getTeacherProfile(String teacherId) async {
    try {
      final response = await supabse
          .from('teacher_profile_view')
          .select()
          .eq('id', teacherId)
          .single();

      return TeacherProfileModel.fromJson(response);
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }
@override
  Future<TeacherProfileModel> updateTeacherProfile({
    required String name,
    required String subject,
    required String bio,
    required int yearsExperience,
    required String phone,
    required String teacherId,
  }) async {
    try {
      await supabse
          .from('teacher')
          .update({
        'name': name,
        'subject': subject,
        'bio': bio,
        'phone': phone,
      })
          .eq('id', teacherId);

      await supabse
          .from('teacher_profiles')
          .update({
        'years_experience': yearsExperience,
        'updated_at': DateTime.now().toIso8601String(),
      })
          .eq('teacher_id', teacherId);

      final response = await supabse
          .from('teacher_profile_view')
          .select()
          .eq('id', teacherId)
          .single();

      log('updateTeacherProfile response: $response');
      return TeacherProfileModel.fromJson(response);
    } on AppError {
      rethrow;
    } catch (e) {
      log('Error in updateTeacherProfile: ${e.toString()}');
      throw ServerError();
    }
  }
}
