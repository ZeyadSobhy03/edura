import 'dart:developer';

import 'package:edura/core/error/app_error.dart';
import 'package:edura/presentation/role/teacher/tabs/students/data/data_source/student/student_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/students/data/model/student_detail_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StudentSupabaseDataSource implements StudentRemoteDataSource {

final supabase=Supabase.instance.client;
  @override
  Future<List<StudentModel>> getStudents() async {
    try {
      final response = await supabase.from('students').select();

      return response.map((json) => StudentModel.fromJson(json)).toList();
    } on AppError  {
      rethrow;
    }
    catch (e) {
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
      student_contacts (*),
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
    }
    catch (e) {
      log('Error in getStudentDetails: ${e.toString()}');
      throw ServerError();
    }
  }
}
