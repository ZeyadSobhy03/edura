import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/payment/data/repositories/payment_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../../teacher_grades/data/model/grade_model.dart';

@injectable
class PaymentUseCase {
  final PaymentRepositories paymentRepositories;

  PaymentUseCase({required this.paymentRepositories});

  Future<List<Grade>> getGrades() async {
    return await paymentRepositories.getGrades();
  }

  Future<void> updateGradePrice({
    required String gradeId,
    required double monthlyAmount,
  }) async {
    return await paymentRepositories.updateGradePrice(
      gradeId: gradeId,
      monthlyAmount: monthlyAmount,
    );
  }

  Future<List<GradePaymentStatusModel>> getPaymentsForGrade({
    required String grade,
    required DateTime month,
  }){
    return paymentRepositories.getPaymentsForGrade(
      grade: grade,
      month: month,
    );
  }


  Future<void> markPaid({
    required String studentId,
    required String teacherId,
    required double amount,
    required DateTime month,
  }){
    return paymentRepositories.markPaid(
      studentId: studentId,
      teacherId: teacherId,
      amount: amount,
      month: month,
    );
  }


  Future<void> markUnpaid({required String studentId, required DateTime month}){
    return paymentRepositories.markUnpaid(
      studentId: studentId,
      month: month,
    );
  }



}
