import '../../model/student_notes/note_model.dart';

abstract class StudentNotesRepositories {
  Future<void> createNote({
    required String lessonId,
    required String title,
    required String subject,
    required String content,
    required String studentId,
  });

  Future<void> updateNote({
    required String title,
    required String content,
    required String noteId,
    required String studentId,
  });

  Future<void> deleteNote({required String noteId, required String studentId});

  Future<List<NoteModel>> getNotesOfLesson({
    required String lessonId,
    required String studentId,
  });

  Future<List<NoteModel>> getAllNotes({required String studentId});
}
