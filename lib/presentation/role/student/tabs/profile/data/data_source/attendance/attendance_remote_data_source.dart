import '../../model/attendance/attendance_model.dart';

abstract class AttendanceRemoteDataSource {

  Future<List<AttendanceRecordModel>> getStudentAttendance(String studentId);

}