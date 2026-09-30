import 'dart:developer';

import 'package:edura/core/error/app_error.dart';
import 'package:edura/presentation/role/student/tabs/profile/data/data_source/student_notes/student_notes_remote_data_source.dart';
import 'package:edura/presentation/role/student/tabs/profile/data/model/student_notes/note_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: StudentNotesRemoteDataSource)
class StudentSupabaseDataSource implements StudentNotesRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<void> createNote({
    required String lessonId,
    required String title,
    required String subject,

    required String content,
    required String studentId,
  }) async {
    try {
      final response = await supabase.from('student_lesson_notes').insert({
        'student_id': studentId,
        'lesson_id': lessonId,
        'title': title,
        'content': content,
        'subject': subject,
      });
      return response;
    } on AppError {
      rethrow;
    } catch (e) {
      throw const ServerError();
    }
  }

  @override
  Future<void> deleteNote({
    required String noteId,
    required String studentId,
  }) async {
    try {
      await supabase
          .from('student_lesson_notes')
          .delete()
          .eq('id', noteId)
          .eq('student_id', studentId);
    } on AppError {
      rethrow;
    } catch (e) {
      throw const ServerError();
    }
  }

  @override
  Future<List<NoteModel>> getAllNotes({required String studentId}) async {
    try {
      final response = await supabase
          .from('student_lesson_notes')
          .select()
          .eq('student_id', studentId);
      return (response as List<dynamic>)
          .map((note) => NoteModel.fromJson(note))
          .toList();
    } on AppError {
      rethrow;
    } catch (e) {
      throw const ServerError();
    }
  }

  @override
  Future<List<NoteModel>> getNotesOfLesson({
    required String lessonId,
    required String studentId,
  }) async {
    try {
      final response = await supabase
          .from('student_lesson_notes')
          .select()
          .eq('lesson_id', lessonId)
          .eq('student_id', studentId);
      return (response as List<dynamic>)
          .map((note) => NoteModel.fromJson(note))
          .toList();
    } on AppError catch (e) {
      log(
        'Error fetching notes for lesson $lessonId and student $studentId: $e',
      );
      rethrow;
    } catch (e) {
      log(
        'Unexpected error fetching notes for lesson $lessonId and student $studentId: $e',
      );
      throw const ServerError();
    }
  }

  @override
  Future<void> updateNote({
    required String title,
    required String content,
    required String noteId,
    required String studentId,
  }) async {
    try {
      await supabase
          .from('student_lesson_notes')
          .update({'title': title, 'content': content})
          .eq('id', noteId)
          .eq('student_id', studentId);
    } on AppError {
      rethrow;
    } catch (e) {
      throw const ServerError();
    }
  }
}
