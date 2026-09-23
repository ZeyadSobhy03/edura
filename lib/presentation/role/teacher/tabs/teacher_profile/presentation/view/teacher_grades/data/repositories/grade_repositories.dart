import '../model/grade_model.dart';

abstract class GardeRepositories {
  Future<List<Grade>> fetchGrades({String? teacherId});

  Future<void> addGrade({required String teacherId, required String name, required double monthlyAmount});

  Future<void> updateGrade({
    required String id,
    required String name,
    required double monthlyAmount,
  });

  Future<void> deleteGrade({required String id});
}
