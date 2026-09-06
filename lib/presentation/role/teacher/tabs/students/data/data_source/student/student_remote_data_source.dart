import 'package:edura/presentation/role/teacher/tabs/students/data/model/student_detail_model.dart';

abstract class StudentRemoteDataSource {
  Future<List<StudentModel>> getStudents();
  Future<StudentModel> getStudentDetails({
    required String studentId,
  });
}