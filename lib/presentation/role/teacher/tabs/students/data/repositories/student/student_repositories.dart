import '../../model/student_detail_model.dart';

abstract class StudentRepositories {

  Future<List<StudentModel>> getStudents();
  Future<StudentModel> getStudentDetails({
    required String studentId,
  });
  Future<void> markAttendance({
    required String lessonId,
    required DateTime date,
    required List<Map<String, String>> entries,
  });

}