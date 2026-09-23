import 'dart:developer';

import 'package:edura/core/error/app_error.dart';
import 'package:edura/presentation/role/teacher/tabs/students/data/data_source/student/student_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/students/data/model/student_detail_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: StudentRemoteDataSource)
class StudentSupabaseDataSource implements StudentRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<StudentModel>> getStudents() async {
    try {
      final response = await supabase.from('students').select();
      log('getStudents response: $response');

      return response.map((json) => StudentModel.fromJson(json)).toList();
    } on AppError catch (e) {
      log('AppError in getStudents: ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Error in getStudents: ${e.toString()}');
      throw ServerError();
    }
  }

  @override
  Future<StudentModel> getStudentDetails({required String studentId}) async {
    try {
      final response = await supabase
          .from('students')
          .select('''
      *,
      student_lesson_progress (*),
      student_attendance (*)
    ''')
          .eq('id', studentId)
          .single();
      log('DETAIL RESPONSE: $response');

      return StudentModel.fromDetailsJson(response);
    } on AppError catch (e) {
      log('AppError in getStudentDetails: ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Error in getStudentDetails: ${e.toString()}');
      throw ServerError();
    }
  }

  @override
  Future<void> markAttendance({
    required String lessonId,
    required DateTime date,
    required List<Map<String, String>> entries,
  }) async {
    try {
      final rows = entries
          .map(
            (e) => {
              'student_id': e['studentId'],
              'lesson_id': lessonId,
              'date': date.toIso8601String().split('T').first,
              'status': e['status'],
            },
          )
          .toList();

      await supabase
          .from('student_attendance')
          .upsert(rows, onConflict: 'student_id,lesson_id,date');
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }
}
