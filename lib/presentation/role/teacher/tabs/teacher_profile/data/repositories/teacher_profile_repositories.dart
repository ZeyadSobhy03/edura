import '../model/teacher_profile_model.dart';

abstract class TeacherProfileRepositories {

  Future<TeacherProfileModel> getTeacherProfile(String teacherId);

  Future<TeacherProfileModel> updateTeacherProfile({
    required String teacherId,
    required String name,
    required String subject,
    required String bio,
    required int yearsExperience,
    required String phone,
  });

}