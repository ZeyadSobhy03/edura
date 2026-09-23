import 'package:edura/presentation/role/teacher/tabs/students/data/data_source/student/student_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/students/data/model/student_detail_model.dart';
import 'package:edura/presentation/role/teacher/tabs/students/data/repositories/student/student_repositories.dart';
import 'package:injectable/injectable.dart';



@LazySingleton(as: StudentRepositories)
class StudentRepositoriesImp implements StudentRepositories {
  final StudentRemoteDataSource remoteDataSource;
  StudentRepositoriesImp({required this.remoteDataSource});

  @override
  Future<List<StudentModel>> getStudents() {
    return remoteDataSource.getStudents();
  }

  @override
  Future<StudentModel> getStudentDetails({required String studentId}) {
    return remoteDataSource.getStudentDetails(studentId: studentId);
  }

  @override
  Future<void> markAttendance({required String lessonId, required DateTime date, required List<Map<String, String>> entries}) {
    return remoteDataSource.markAttendance(lessonId: lessonId, date: date, entries: entries);
  }

}