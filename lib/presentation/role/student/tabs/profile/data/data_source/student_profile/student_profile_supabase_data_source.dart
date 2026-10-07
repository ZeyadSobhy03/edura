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
      final current = supabase.auth.currentUser?.id;
      if (current == null || current != studentId) {
        throw const AuthException('Student id does not match the session');
      }

      final profile = await supabase
          .from('students')
          .select()
          .eq('id', studentId)
          .single();

      final rows = await supabase.rpc('get_my_stats') as List;
      final stats = rows.isNotEmpty
          ? Map<String, dynamic>.from(rows.first as Map)
          : <String, dynamic>{};

      return StudentModel.fromJson({
        ...profile,
        'lessons': stats['lessons'] ?? profile['lessons'],
        'average_score': stats['average_score'] ?? profile['average_score'],
        'points': stats['points'],
        'rank': stats['rank'],
      });
    } catch (e) {
      throw Exception('Failed to fetch student profile: $e');
    }
  }

  @override
  Future<StudentModel> updateStudentProfile({
    required String studentId,
    required String name,
    required String phone,
  }) async {
    try {
      final current = supabase.auth.currentUser?.id;
      if (current == null || current != studentId) {
        throw const AuthException('Student id does not match the session');
      }

      final updatedProfile = await supabase
          .from('students')
          .update({'name': name, 'phone': phone})
          .eq('id', studentId)
          .select()
          .single();

      return StudentModel.fromJson(Map<String, dynamic>.from(updatedProfile));
    } catch (e) {
      throw Exception('Failed to update student profile: $e');
    }
  }
}
