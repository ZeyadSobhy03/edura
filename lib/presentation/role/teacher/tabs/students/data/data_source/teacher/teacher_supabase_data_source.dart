import 'dart:developer';

import 'package:edura/core/error/app_error.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/model/teacher_model.dart';
import 'teacher_remote_data_source.dart';

class TeacherSupabaseDataSource implements TeacherRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<TeacherModel>> getTeachers() async {
    try {
      final response = await supabase.from('teacher').select();

      log('getTeachers response: $response');

      return response.map((json) => TeacherModel.fromJson(json)).toList();
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }

  @override
  Future<String> getOrCreateConversation({
    required String studentId,
    required String teacherId,
  }) async {
    try {
      final existing = await supabase
          .from('conversations')
          .select('id')
          .eq('student_id', studentId)
          .eq('teacher_id', teacherId)
          .maybeSingle();

      if (existing != null) {
        return existing['id'].toString();
      }

      final inserted = await supabase
          .from('conversations')
          .insert({
        'student_id': studentId,
        'teacher_id': teacherId,
        'last_message': '',
        'last_message_time': DateTime.now().toIso8601String(),
        'is_online': false,
      })
          .select('id')
          .single();

      return inserted['id'].toString();
    } on AppError catch (e) {
      log('AppError in getOrCreateConversation: ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Error in getOrCreateConversation: ${e.toString()}');
      throw ServerError();
    }
  }
}