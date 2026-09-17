import 'package:edura/presentation/role/teacher/tabs/teacher_profile/data/data_source/teacher_profile_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/data/model/teacher_profile_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/data/repositories/teacher_profile_repositories.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: TeacherProfileRepositories)
class TeacherProfileRepositoriesImp implements TeacherProfileRepositories{

  final TeacherProfileRemoteDataSource remoteDataSource;
  TeacherProfileRepositoriesImp({required this.remoteDataSource});

  @override
  Future<TeacherProfileModel> getTeacherProfile(String teacherId) {
    return remoteDataSource.getTeacherProfile(teacherId);
  }
}