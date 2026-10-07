
import '../../model/attendance/attendance_model.dart';

abstract class AttendanceRepositories {
  Future<List<AttendanceRecordModel>> getStudentAttendance(String studentId);

}