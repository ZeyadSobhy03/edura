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
}
