import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/data/data_source/grade_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/data/model/grade_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/data/repositories/grade_repositories.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: GardeRepositories)
class GardeRepositoriesImp implements GardeRepositories {

  final GradeRemoteDataSource remoteDataSource;
  GardeRepositoriesImp({required this.remoteDataSource});

  @override
  Future<void> addGrade({required String teacherId, required String name, required double monthlyAmount}) {
    return remoteDataSource.addGrade(teacherId: teacherId, name: name, monthlyAmount: monthlyAmount);
  }

  @override
  Future<void> deleteGrade({required String id}) {
    return remoteDataSource.deleteGrade(id: id);
  }

  @override
  Future<List<Grade>> fetchGrades({String? teacherId}) {
    return remoteDataSource.fetchGrades(teacherId: teacherId);
  }

  @override
  Future<void> updateGrade({required String id, required String name, required double monthlyAmount}) {
    return remoteDataSource.updateGrade(id: id, name: name, monthlyAmount: monthlyAmount);
  }



}