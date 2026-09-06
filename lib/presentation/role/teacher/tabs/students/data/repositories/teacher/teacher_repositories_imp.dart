
import '../../../../../../../../core/model/teacher_model.dart';
import '../../data_source/teacher/teacher_remote_data_source.dart';
import 'teacher_repositories.dart';

class TeacherRepositoriesImp implements TeacherRepositories {
  final TeacherRemoteDataSource remoteDataSource;

  TeacherRepositoriesImp({required this.remoteDataSource});

  @override
  Future<List<TeacherModel>> getTeachers() {
    return remoteDataSource.getTeachers();
  }
}