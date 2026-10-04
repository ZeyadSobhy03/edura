import 'package:edura/core/model/exam_model.dart';
import 'package:edura/presentation/role/student/tabs/exams/data/data_source/exam_remote_data_source.dart';
import 'package:edura/presentation/role/student/tabs/exams/data/model/student_question_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/student_question.dart';

@LazySingleton(as: ExamRemoteDataSource)
class ExamSupabaseDataSource implements ExamRemoteDataSource {
  final supabase = Supabase.instance.client;

  void _assertCurrentUser(String studentId) {
    final current = supabase.auth.currentUser?.id;
    if (current == null) throw const AuthException('Not authenticated');
    if (current != studentId) {
      throw const AuthException('Student id does not match the session');
    }
  }

  @override
  Future<List<ExamModel>> fetchExams({required String studentId}) async {
    _assertCurrentUser(studentId);

    final data = await supabase
        .from('student_exams')
        .select()
        .order('created_at', ascending: false);

    return data.map<ExamModel>((e) => ExamModel.fromJson(e)).toList();
  }

  @override
  Future<({String attemptId, List<StudentQuestionModel> questions})> startExam(
    String examId, {
    required String studentId,
  }) async {
    _assertCurrentUser(studentId);

    final res =
        await supabase.rpc(
              'start_exam',
              params: {'p_exam_id': int.parse(examId)},
            )
            as Map<String, dynamic>;

    final list = (res['questions'] as List)
        .map<StudentQuestionModel>(
          (q) => StudentQuestionModel.fromJson(Map<String, dynamic>.from(q)),
        )
        .toList();

    return (attemptId: res['attempt_id'] as String, questions: list);
  }

  @override
  Future<ExamResultModel> submitExam({
    required String attemptId,
    required String studentId,
    required Map<String, int> answers,
  }) async {
    _assertCurrentUser(studentId);

    final res = await supabase.rpc(
      'submit_exam',
      params: {'p_attempt_id': attemptId, 'p_answers': answers},
    );
    return ExamResultModel.fromJson(res as Map<String, dynamic>);
  }

  @override
  Future<List<ReviewQuestionModel>> fetchReview(
    String examId, {
    required String studentId,
  }) async {
    _assertCurrentUser(studentId);

    final res =
        await supabase.rpc(
              'get_exam_review',
              params: {'p_exam_id': int.parse(examId)},
            )
            as List;

    return res
        .map<ReviewQuestionModel>(
          (q) => ReviewQuestionModel.fromJson(Map<String, dynamic>.from(q)),
        )
        .toList();
  }
}
