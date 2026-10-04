import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/exam/question_draft_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/data_source/exam/exam_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/error/app_error.dart';

@LazySingleton(as: ExamRemoteDataSource)
class ExamSupabaseDataSource implements ExamRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<Map<String, dynamic>> createExam({
    required String title,
    required String teacherId,
    required String subject,
    required int durationMinutes,
    required List<QuestionDraftModel> questions,
    required DateTime startDate,
    required DateTime endDate,
    List<String> studentIds = const [],
  }) async {
    try {
      final res = await supabase.rpc('create_exam', params: {
        'p_title': title,
        'p_subject': subject,
        'p_duration_minutes': durationMinutes,
        'p_start_date': startDate.toUtc().toIso8601String(),
        'p_end_date': endDate.toUtc().toIso8601String(),
        'p_questions': questions
            .map((q) => {
          'question_text': q.questionText,
          'options': q.options,
          'correct_option_index': q.correctOptionIndex,
        })
            .toList(),
        'p_student_ids': studentIds,
      });
      return res as Map<String, dynamic>;
    } on SocketException catch (e) {
      log('SocketException: $e');
      throw const NoInternetError();
    } on TimeoutException {
      throw const TimeoutError();
    } on PostgrestException catch (e) {
      log('PostgrestException: ${e.message}');
      throw ServerError();
    } on AppError catch (e) {
      log('AppError: $e');
      rethrow;
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('Failed to create exam: $e');
    }
  }
}
