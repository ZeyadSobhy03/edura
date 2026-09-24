import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/payment/data/data_source/payment_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/payment/data/repositories/payment_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../../teacher_grades/data/model/grade_model.dart';

@LazySingleton(as: PaymentRepositories)
class PaymentRepositoriesImp implements PaymentRepositories {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoriesImp({required this.remoteDataSource});

  @override
  Future<List<Grade>> getGrades() async {
    return await remoteDataSource.getGrades();
  }

  @override
  Future<void> updateGradePrice({
    required String gradeId,
    required double monthlyAmount,
  }) async {
    return await remoteDataSource.updateGradePrice(
      gradeId: gradeId,
      monthlyAmount: monthlyAmount,
    );
  }

  @override
  Future<List<GradePaymentStatusModel>> getPaymentsForGrade({required String grade, required DateTime month}) {
    return remoteDataSource.getPaymentsForGrade(grade: grade, month: month);
  }

  @override
  Future<void> markPaid({required String studentId, required String teacherId, required double amount, required DateTime month}) {
    return remoteDataSource.markPaid(studentId: studentId, teacherId: teacherId, amount: amount, month: month);
  }

  @override
  Future<void> markUnpaid({required String studentId, required DateTime month}) {
    return remoteDataSource.markUnpaid(studentId: studentId, month: month);
  }



}
