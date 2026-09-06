import '../../model/student_detail_model.dart';

abstract class StudentRepositories {

  Future<List<StudentModel>> getStudents();
  Future<StudentModel> getStudentDetails({
    required String studentId,
  });

}