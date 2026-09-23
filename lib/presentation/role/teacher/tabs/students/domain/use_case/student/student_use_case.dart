import 'package:edura/presentation/role/teacher/tabs/students/data/repositories/student/student_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/student_detail_model.dart';
@injectable
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
  Future<void> markAttendance({
    required String lessonId,
    required DateTime date,
    required List<Map<String, String>> entries,
  }){
    return repositories.markAttendance(
      lessonId: lessonId,
      date: date,
      entries: entries,
    );
  }
}