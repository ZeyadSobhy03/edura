import '../../../../../../teacher/tabs/students/data/model/student_detail_model.dart';

abstract class StudentProfileRepositories {
  Future<StudentModel> getStudentProfile({required String studentId});

}