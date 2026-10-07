import 'package:edura/presentation/role/student/tabs/profile/data/model/attendance/attendance_model.dart';
import 'package:edura/presentation/role/student/tabs/profile/data/data_source/attendance/attendance_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AttendanceRemoteDataSource)
class AttendanceSupabaseDataSource implements AttendanceRemoteDataSource {
  final supabase = Supabase.instance.client;
  @override
  Future<List<AttendanceRecordModel>> getStudentAttendance(
      String studentId,
      ) async {
    try {
      final current = supabase.auth.currentUser?.id;
      if (current == null || current != studentId) {
        throw const AuthException('Student id does not match the session');
      }

      final data = await supabase.rpc('get_my_attendance') as List;

      return data
          .map((e) =>
          AttendanceRecordModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch student attendance: $e');
    }
  }
}
