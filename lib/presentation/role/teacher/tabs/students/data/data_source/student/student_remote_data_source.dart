import 'package:edura/presentation/role/teacher/tabs/students/data/model/student_detail_model.dart';

import '../../model/student_attendance_history.dart';

abstract class StudentRemoteDataSource {
  Future<List<StudentModel>> getStudents();
  Future<StudentModel> getStudentDetails({
    required String studentId,
  });
  Future<void> markAttendance({
    required String lessonId,
    required DateTime date,
    required List<Map<String, String>> entries,
    required String teacherId,
  });
  Future<Map<String, String>> getAttendanceForLesson({
    required String lessonId,
    required DateTime date,
  });
  Future<List<StudentAttendanceHistory>> getAttendanceHistoryForGrade({
    required String grade,
  });
}