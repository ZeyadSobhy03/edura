import 'package:edura/core/error/app_error.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/data/model/grade_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/payment/data/data_source/payment_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: PaymentRemoteDataSource)
class PaymentSupabaseDataSource implements PaymentRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Grade>> getGrades() async {
    try {
      final teacherId = supabase.auth.currentUser!.id;
      final response = await supabase
          .from('grades')
          .select()
          .eq('teacher_id', teacherId);

      return response.map((json) => Grade.fromJson(json)).toList();
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }

  String _monthKey(DateTime d) =>
      DateTime(d.year, d.month, 1).toIso8601String().split('T').first;

  @override
  Future<List<GradePaymentStatusModel>> getPaymentsForGrade({
    required String grade,
    required DateTime month,
  }) async {
    try {
      final teacherId = supabase.auth.currentUser!.id;

      final students = await supabase
          .from('students')
          .select('id, name')
          .eq('grade', grade)
          .eq('teacher_id', teacherId);

      final ids = students.map((s) => s['id'] as String).toList();

      final paidIds = <String>{};
      if (ids.isNotEmpty) {
        final paid = await supabase
            .from('payments')
            .select('student_id')
            .eq('month', _monthKey(month))
            .inFilter('student_id', ids);
        paidIds.addAll(paid.map((p) => p['student_id'] as String));
      }

      return students
          .map(
            (s) => GradePaymentStatusModel(
              studentId: s['id'] as String,
              studentName: s['name'] as String,
              paidThisMonth: paidIds.contains(s['id']),
            ),
          )
          .toList();
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }

  @override
  Future<void> markPaid({
    required String studentId,
    required String teacherId,
    required double amount,
    required DateTime month,
  }) async {
    try {
      await supabase.from('payments').upsert({
        'student_id': studentId,
        'teacher_id': teacherId,
        'amount': amount,
        'status': 'completed',
        'month': _monthKey(month),
      }, onConflict: 'student_id,month');
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }

  @override
  Future<void> markUnpaid({
    required String studentId,
    required DateTime month,
  }) async {
    try {
      await supabase
          .from('payments')
          .delete()
          .eq('student_id', studentId)
          .eq('month', _monthKey(month));
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }

  @override
  Future<void> updateGradePrice({
    required String gradeId,
    required double monthlyAmount,
  }) async {
    try {
      await supabase
          .from('grades')
          .update({'monthly_amount': monthlyAmount})
          .eq('id', gradeId);
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }
}
