import 'package:edura/presentation/role/teacher/tabs/teacher_profile/data/repositories/teacher_profile_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/teacher_profile_model.dart';
@injectable
class TeacherProfileUseCase {
  final TeacherProfileRepositories teacherProfileRepositories;
  TeacherProfileUseCase({required this.teacherProfileRepositories});
  Future<TeacherProfileModel> getTeacherProfile(String teacherId){
    return teacherProfileRepositories.getTeacherProfile(teacherId);
  }
  Future<TeacherProfileModel> updateTeacherProfile({
    required String name,
    required String subject,
    required String bio,
    required int yearsExperience,
    required String phone,
    required String teacherId,
  }){
    return teacherProfileRepositories.updateTeacherProfile(
      name: name,
      subject: subject,
      bio: bio,
      yearsExperience: yearsExperience,
      phone: phone,
      teacherId: teacherId
    );
  }

}