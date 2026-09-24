import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/data/model/grade_model.dart';

abstract class PaymentRepositories {
  Future<List<Grade>> getGrades();

  Future<void> updateGradePrice({
    required String gradeId,
    required double monthlyAmount,
  });

  Future<List<GradePaymentStatusModel>> getPaymentsForGrade({
    required String grade,
    required DateTime month,
  });

  Future<void> markPaid({
    required String studentId,
    required String teacherId,
    required double amount,
    required DateTime month,
  });

  Future<void> markUnpaid({required String studentId, required DateTime month});

}