import 'package:edura/presentation/role/teacher/tabs/teacher_profile/data/model/teacher_profile_model.dart';

abstract class TeacherProfileRemoteDataSource {
  Future<TeacherProfileModel> getTeacherProfile(String teacherId);
}