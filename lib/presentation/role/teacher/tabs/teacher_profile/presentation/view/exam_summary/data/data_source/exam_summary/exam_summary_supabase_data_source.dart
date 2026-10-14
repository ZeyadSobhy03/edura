import 'package:edura/core/error/app_error.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/exam_summary/data/data_source/exam_summary/exam_summary_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/exam_summary/data/model/exam_summary/exam_summary.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: ExamSummaryRemoteDataSource)
class ExamSummarySupabaseDataSource implements ExamSummaryRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<ExamSummaryModel>> fetchExams() async {
    try {
      final rows = await supabase.rpc('get_teacher_exams_summary') as List;
      return rows
          .map((e) => ExamSummaryModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } on PostgrestException {
      throw ServerError();
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }

  @override
  Future<List<StudentResultModel>> fetchResults(int examId) async {
    try {
      final rows =
          await supabase.rpc(
                'get_exam_student_results',
                params: {'p_exam_id': examId},
              )
              as List;
      return rows
          .map((e) => StudentResultModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } on PostgrestException {
      throw ServerError();
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }
}
