import 'package:edura/presentation/role/student/tabs/profile/data/model/student_notes/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_case/student_notes/student_notes_use_case.dart';

@injectable
class StudentNotesCubit extends Cubit<StudentNotesState> {
  final StudentNotesUseCase studentNotesUseCase;

  StudentNotesCubit({required this.studentNotesUseCase})
    : super(StudentNotesInitial());

  Future<void> getNotesOfLesson({
    required String lessonId,
    required String studentId,
  }) async {
    emit(StudentNotesLoading());

    try {
      final notes = await studentNotesUseCase.getNotesOfLesson(
        lessonId: lessonId,
        studentId: studentId,
      );

      emit(StudentNotesLoaded(notes));
    } catch (e) {
      emit(StudentNotesFailure(e.toString()));
    }
  }

  Future<void> getAllNotes({required String studentId}) async {
    emit(StudentNotesLoading());

    try {
      final notes = await studentNotesUseCase.getAllNotes(studentId: studentId);

      emit(StudentNotesLoaded(notes));
    } catch (e) {
      emit(StudentNotesFailure(e.toString()));
    }
  }

  Future<void> createNote({
    required String lessonId,
    required String title,
    required String content,
    required String subject,
    required String studentId,
  }) async {
    emit(StudentNotesLoading());

    try {
      await studentNotesUseCase.createNote(
        lessonId: lessonId,
        subject: subject,
        title: title,
        content: content,
        studentId: studentId,
      );

      final notes = await studentNotesUseCase.getAllNotes(studentId: studentId);

      emit(StudentNotesLoaded(notes));
    } catch (e) {
      emit(StudentNotesFailure(e.toString()));
    }
  }

  Future<void> updateNote({
    required String title,
    required String content,
    required String noteId,
    required String studentId,
  }) async {
    emit(StudentNotesLoading());

    try {
      await studentNotesUseCase.updateNote(
        content: content,
        noteId: noteId,
        title: title,
        studentId: studentId,
      );

      final notes = await studentNotesUseCase.getAllNotes(studentId: studentId);

      emit(StudentNotesLoaded(notes));
    } catch (e) {
      emit(StudentNotesFailure(e.toString()));
    }
  }

  Future<void> deleteNote({
    required String noteId,
    required String studentId,
  }) async {
    emit(StudentNotesLoading());

    try {
      await studentNotesUseCase.deleteNote(
        noteId: noteId,
        studentId: studentId,
      );

      final notes = await studentNotesUseCase.getAllNotes(studentId: studentId);

      emit(StudentNotesLoaded(notes));
    } catch (e) {
      emit(StudentNotesFailure(e.toString()));
    }
  }
}

sealed class StudentNotesState {}

class StudentNotesInitial extends StudentNotesState {}

class StudentNotesLoading extends StudentNotesState {}

class StudentNotesLoaded extends StudentNotesState {
  final List<NoteModel> notes;

  StudentNotesLoaded(this.notes);
}

class StudentNotesFailure extends StudentNotesState {
  final String error;

  StudentNotesFailure(this.error);
}
