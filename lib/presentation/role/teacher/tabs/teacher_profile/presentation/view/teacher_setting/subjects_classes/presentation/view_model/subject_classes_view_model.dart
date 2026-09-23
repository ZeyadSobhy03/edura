import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/subject_class_model.dart';
import '../../domain/use_case/subject_classes_use_case.dart';

@injectable
class SubjectClassesCubit extends Cubit<SubjectClassesState> {
  final SubjectClassesUseCase subjectClassesUseCase;

  SubjectClassesCubit({required this.subjectClassesUseCase})
    : super(SubjectClassesInitial());

  Future<void> fetchSubjects({required String teacherId}) async {
    emit(SubjectClassesLoading());
    try {
      final subjects = await subjectClassesUseCase.fetchSubjects(
        teacherId: teacherId,
      );
      emit(SubjectClassesLoaded(subjects));
    } catch (e) {
      emit(SubjectClassesError(e.toString()));
    }
  }

  Future<void> updateSubject({
    required String id,
    required String subjectName,
    required String teacherId,
  }) async {
    try {
      await subjectClassesUseCase.editSubject(
        teacherId: teacherId,
        id: id,
        subjectName: subjectName,
      );
      await fetchSubjects(teacherId: teacherId);
    } catch (e) {
      emit(SubjectClassesError(e.toString()));
    }
  }

  Future<void> addSubject({
    required String teacherId,
    required String subjectName,
  }) async {
    try {
      await subjectClassesUseCase.addSubject(
        teacherId: teacherId,
        subjectName: subjectName,
      );
      await fetchSubjects(teacherId: teacherId);
    } catch (e) {
      emit(SubjectClassesError(e.toString()));
    }
  }

  Future<void> deleteSubject({
    required String id,
    required String teacherId,
  }) async {
    try {
      await subjectClassesUseCase.deleteSubject(id: id);
      await fetchSubjects(teacherId: teacherId);
    } catch (e) {
      emit(SubjectClassesError(e.toString()));
    }
  }
}

sealed class SubjectClassesState {}

class SubjectClassesInitial extends SubjectClassesState {}

class SubjectClassesLoading extends SubjectClassesState {}

class SubjectClassesLoaded extends SubjectClassesState {
  final List<SubjectClassModel> subjects;

  SubjectClassesLoaded(this.subjects);
}

class SubjectClassesError extends SubjectClassesState {
  final String message;

  SubjectClassesError(this.message);
}
