import 'package:edura/presentation/role/teacher/tabs/teacher_profile/data/data_source/teacher_profile_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/data/model/teacher_profile_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/data/repositories/teacher_profile_repositories.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TeacherProfileRepositories)
class TeacherProfileRepositoriesImp implements TeacherProfileRepositories {
  final TeacherProfileRemoteDataSource remoteDataSource;

  TeacherProfileRepositoriesImp({required this.remoteDataSource});

  @override
  Future<TeacherProfileModel> getTeacherProfile(String teacherId) {
    return remoteDataSource.getTeacherProfile(teacherId);
  }

  @override
  Future<TeacherProfileModel> updateTeacherProfile({
    required String name,
    required String subject,
    required String bio,
    required int yearsExperience,
    required String phone,
    required String teacherId,
  }) {
    return remoteDataSource.updateTeacherProfile(
      name: name,
      subject: subject,
      bio: bio,
      yearsExperience: yearsExperience,
      phone: phone,
      teacherId: teacherId,
    );
  }
}
