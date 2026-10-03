import 'package:edura/presentation/role/teacher/tabs/students/data/model/student_detail_model.dart';

abstract class StudentProfileRemoteDataSource {
  Future<StudentModel> getStudentProfile({required String studentId});
}
