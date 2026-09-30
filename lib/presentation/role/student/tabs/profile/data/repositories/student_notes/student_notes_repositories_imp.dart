import 'package:edura/presentation/role/student/tabs/profile/data/model/student_notes/note_model.dart';
import 'package:edura/presentation/role/student/tabs/profile/data/repositories/student_notes/student_notes_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/student_notes/student_notes_remote_data_source.dart';

@LazySingleton(as: StudentNotesRepositories)
class StudentNotesRepositoriesImp implements StudentNotesRepositories {
  final StudentNotesRemoteDataSource remoteDataSource;

  StudentNotesRepositoriesImp({required this.remoteDataSource});

  @override
  Future<void> createNote({
    required String lessonId,
    required String title,
    required String content,
    required String studentId,
    required String subject,
  }) {
    return remoteDataSource.createNote(
      lessonId: lessonId,
      title: title,
      subject: subject,
      content: content,
      studentId: studentId,
    );
  }

  @override
  Future<void> deleteNote({required String noteId, required String studentId}) {
    return remoteDataSource.deleteNote(noteId: noteId, studentId: studentId);
  }

  @override
  Future<List<NoteModel>> getAllNotes({required String studentId}) {
    return remoteDataSource.getAllNotes(studentId: studentId);
  }

  @override
  Future<List<NoteModel>> getNotesOfLesson({
    required String lessonId,
    required String studentId,
  }) {
    return remoteDataSource.getNotesOfLesson(
      lessonId: lessonId,
      studentId: studentId,
    );
  }

  @override
  Future<void> updateNote({
    required String title,
    required String content,
    required String noteId,
    required String studentId,
  }) {
    return remoteDataSource.updateNote(
      title: title,
      noteId: noteId,
      content: content,
      studentId: studentId,
    );
  }
}
