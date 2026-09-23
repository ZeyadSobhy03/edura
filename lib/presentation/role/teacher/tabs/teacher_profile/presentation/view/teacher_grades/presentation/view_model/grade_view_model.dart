import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/grade_model.dart';
import '../../domain/use_case/grade_use_case.dart';

@injectable
class GardeCubit extends Cubit<GradesState> {
  final GradeUseCase gradeUseCase;

  GardeCubit({required this.gradeUseCase}) : super(GradesInitial());

  Future<void> fetchGrades({String? teacherId}) async {
    emit(GradesLoading());
    try {
      final grades = await gradeUseCase.fetchGrades(teacherId: teacherId);
      emit(GradesLoaded(grades));
    } catch (e) {
      emit(GradesError(e.toString()));
    }
  }

  Future<void> addGrade({
    required String teacherId,
    required String name,
    required double monthlyAmount,
  }) async {
    try {
      await gradeUseCase.addGrade(
        teacherId: teacherId,
        name: name,
        monthlyAmount: monthlyAmount,
      );
      await fetchGrades(teacherId: teacherId);
    } catch (e) {
      emit(GradesError(e.toString()));
    }
  }

  Future<void> updateGrade({
    required String id,
    required String teacherId,
    required String name,
    required double monthlyAmount,
  }) async {
    try {
      await gradeUseCase.updateGrade(
        id: id,
        name: name,
        monthlyAmount: monthlyAmount,
      );
      await fetchGrades(teacherId: teacherId);
    } catch (e) {
      emit(GradesError(e.toString()));
    }
  }

  Future<void> deleteGrade({
    required String id,
    required String teacherId,
  }) async {
    try {
      await gradeUseCase.deleteGrade(id: id);
      await fetchGrades(teacherId: teacherId);
    } catch (e) {
      emit(GradesError(e.toString()));
    }
  }
}

sealed class GradesState {}

class GradesInitial extends GradesState {}

class GradesLoading extends GradesState {}

class GradesLoaded extends GradesState {
  final List<Grade> grades;

  GradesLoaded(this.grades);
}

class GradesError extends GradesState {
  final String message;

  GradesError(this.message);
}
