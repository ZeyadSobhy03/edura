import 'package:edura/presentation/role/student/tabs/profile/data/repositories/student_profile/student_profile_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../teacher/tabs/students/data/model/student_detail_model.dart';
@injectable
class StudentProfileUseCase {

  final StudentProfileRepositories studentProfileRepositories;
  StudentProfileUseCase({required this.studentProfileRepositories});
  Future<StudentModel> getStudentProfile({required String studentId}){
    return studentProfileRepositories.getStudentProfile(studentId: studentId);
  }
}