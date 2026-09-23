import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/data/repositories/grade_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/grade_model.dart';

@injectable
class GradeUseCase {
  final GardeRepositories repositories;

  GradeUseCase({required this.repositories});

  Future<List<Grade>> fetchGrades({String? teacherId}) {
    return repositories.fetchGrades(teacherId: teacherId);
  }

  Future<void> addGrade({required String teacherId, required String name, required double monthlyAmount}) {
    return repositories.addGrade(teacherId: teacherId, name: name , monthlyAmount: monthlyAmount);
  }

  Future<void> updateGrade({
    required String id,
    required String name,
    required double monthlyAmount,
  }) {
    return repositories.updateGrade(
      id: id,
      name: name,
      monthlyAmount: monthlyAmount,
    );
  }

  Future<void> deleteGrade({required String id}) {
    return repositories.deleteGrade(id: id);
  }
}
