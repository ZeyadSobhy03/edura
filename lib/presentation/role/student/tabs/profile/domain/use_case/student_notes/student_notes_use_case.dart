import 'package:edura/presentation/role/student/tabs/profile/data/repositories/student_notes/student_notes_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/student_notes/note_model.dart';

@injectable
class StudentNotesUseCase {
  final StudentNotesRepositories repositories;

  StudentNotesUseCase({required this.repositories});

  Future<void> createNote({
    required String lessonId,
    required String title,
    required String content,
    required String studentId,
    required String subject,
  }) {
    return repositories.createNote(
      lessonId: lessonId,
      subject: subject,
      title: title,
      content: content,
      studentId: studentId,
    );
  }

  Future<void> updateNote({
    required String title,
    required String content,
    required String noteId,
    required String studentId,
  }) {
    return repositories.updateNote(
      title: title,
      content: content,
      noteId: noteId,
      studentId: studentId,
    );
  }

  Future<void> deleteNote({required String noteId, required String studentId}) {
    return repositories.deleteNote(noteId: noteId, studentId: studentId);
  }

  Future<List<NoteModel>> getNotesOfLesson({
    required String lessonId,
    required String studentId,
  }) {
    return repositories.getNotesOfLesson(
      lessonId: lessonId,
      studentId: studentId,
    );
  }

  Future<List<NoteModel>> getAllNotes({required String studentId}) {
    return repositories.getAllNotes(studentId: studentId);
  }
}
