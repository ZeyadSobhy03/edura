import 'package:injectable/injectable.dart';

import '../../../data/model/attendance/attendance_model.dart';
import '../../../data/repositories/attendance/attendance_repositories.dart';

@injectable
class AttendanceUseCase {
  final AttendanceRepositories attendanceRepositories;

  AttendanceUseCase({required this.attendanceRepositories});

  Future<List<AttendanceRecordModel>> getStudentAttendance(String studentId) {
    return attendanceRepositories.getStudentAttendance(studentId);
  }
}
