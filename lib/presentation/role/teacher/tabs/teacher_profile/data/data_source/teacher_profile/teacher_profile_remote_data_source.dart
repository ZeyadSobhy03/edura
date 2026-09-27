import 'package:edura/presentation/role/teacher/tabs/teacher_profile/data/model/teacher_profile_model.dart';

abstract class TeacherProfileRemoteDataSource {
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
