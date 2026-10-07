
import 'package:edura/presentation/role/student/tabs/profile/data/model/attendance/attendance_model.dart';
import 'package:edura/presentation/role/student/tabs/profile/data/repositories/attendance/attendance_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/attendance/attendance_remote_data_source.dart';
@LazySingleton(as: AttendanceRepositories)
class AttendanceRepositoriesImp  implements AttendanceRepositories{
  final AttendanceRemoteDataSource attendanceRemoteDataSource;
  AttendanceRepositoriesImp({required this.attendanceRemoteDataSource});

  @override
  Future<List<AttendanceRecordModel>> getStudentAttendance(String studentId) {
    return attendanceRemoteDataSource.getStudentAttendance(studentId);
  }

}