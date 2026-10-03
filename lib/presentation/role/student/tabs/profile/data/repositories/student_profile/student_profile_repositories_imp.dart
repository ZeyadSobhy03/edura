import 'package:edura/presentation/role/student/tabs/profile/data/data_source/student_profile/student_profile_remote_data_source.dart';
import 'package:edura/presentation/role/student/tabs/profile/data/repositories/student_profile/student_profile_repositories.dart';
import 'package:edura/presentation/role/teacher/tabs/students/data/model/student_detail_model.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: StudentProfileRepositories)
class StudentProfileRepositoriesImp implements StudentProfileRepositories {

  final StudentProfileRemoteDataSource remoteDataSource;
  StudentProfileRepositoriesImp({required this.remoteDataSource});

  @override
  Future<StudentModel> getStudentProfile({required String studentId}) {
    return remoteDataSource.getStudentProfile(studentId: studentId);
  }

}