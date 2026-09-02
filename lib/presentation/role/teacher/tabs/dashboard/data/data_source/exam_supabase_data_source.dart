import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/question_draft_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/data_source/exam_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/error/app_error.dart';

class ExamSupabaseDataSource implements ExamRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<Map<String, dynamic>> createExam({
    required String title,
    required String subject,
    required int durationMinutes,
    required List<QuestionDraftModel> questions,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        throw const UnauthorizedError();
      }

      final examResponse = await supabase
          .from('exams')
          .insert({
            'title': title,
            'subject': subject,
            'duration_minutes': durationMinutes,
            'teacher_id': user.id,
            'start_date': startDate.toIso8601String(),
            'end_date': endDate.toIso8601String(),
          })
          .select()
          .single();

      final questionRows = questions
          .map(
            (question) => {
              'exam_id': examResponse['id'],
              'question_text': question.questionText,
              'options': question.options,
              'correct_option_index': question.correctOptionIndex,
            },
          )
          .toList();

      await supabase.from('exam_questions').insert(questionRows);

      return examResponse;
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
