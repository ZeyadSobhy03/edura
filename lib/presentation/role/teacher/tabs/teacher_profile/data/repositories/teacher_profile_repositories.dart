import '../model/teacher_profile_model.dart';

abstract class TeacherProfileRepositories {

  Future<TeacherProfileModel> getTeacherProfile(String teacherId);



}