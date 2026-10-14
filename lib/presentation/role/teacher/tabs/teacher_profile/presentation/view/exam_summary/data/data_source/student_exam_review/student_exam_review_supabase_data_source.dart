import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/exam_summary/data/data_source/student_exam_review/student_exam_review_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/exam_summary/data/model/student_exam_review/student_exam_review.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../../../../core/error/app_error.dart';

@LazySingleton(as: StudentExamReviewRemoteDataSource)
class StudentExamReviewSupabaseDataSource
    implements StudentExamReviewRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<StudentReviewData> examReview(int examId, String studentId) async {
    try {
      final response = await Supabase.instance.client.rpc(
        'get_student_exam_review',
        params: {'p_exam_id': examId, 'p_student_id': studentId},
      );
      return StudentReviewData.fromJson(Map<String, dynamic>.from(response));
    } on PostgrestException {
      throw ServerError();
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }
}
