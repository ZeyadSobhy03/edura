import 'package:edura/presentation/role/student/tabs/profile/data/data_source/student_profile/student_profile_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/students/data/model/student_detail_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: StudentProfileRemoteDataSource)
class StudentProfileSupabaseDataSource
    implements StudentProfileRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<StudentModel> getStudentProfile({required String studentId}) async {
    try {
      final response = await supabase
          .from('students')
          .select()
          .eq('id', studentId)
          .single();

      return StudentModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch student profile: $e');
    }
  }
}
