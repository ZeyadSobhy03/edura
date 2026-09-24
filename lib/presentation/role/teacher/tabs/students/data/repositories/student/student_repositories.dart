import '../../model/student_attendance_history.dart';
import '../../model/student_detail_model.dart';

abstract class StudentRepositories {
  Future<List<StudentModel>> getStudents();

  Future<StudentModel> getStudentDetails({required String studentId});

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
