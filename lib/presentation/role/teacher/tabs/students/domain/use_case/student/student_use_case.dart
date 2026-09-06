import 'package:edura/presentation/role/teacher/tabs/students/data/repositories/student/student_repositories.dart';

import '../../../data/model/student_detail_model.dart';

class StudentUseCase {
  final StudentRepositories repositories;
  StudentUseCase({required this.repositories});
  Future<List<StudentModel>> getStudents(){
    return repositories.getStudents();
  }
  Future<StudentModel> getStudentDetails({
    required String studentId,
  }){
    return repositories.getStudentDetails(studentId: studentId);
  }
}