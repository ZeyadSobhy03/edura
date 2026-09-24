import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../teacher_grades/data/model/grade_model.dart';
import '../../domain/use_case/payment_use_case.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  final PaymentUseCase paymentUseCase;

  PaymentCubit({required this.paymentUseCase}) : super(PaymentInitial());

  Future<void> getGrades() async {
    emit(PaymentLoading());
    try {
      final grades = await paymentUseCase.getGrades();
      emit(PaymentLoaded(grades: grades));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> selectGrade(String grade, DateTime month) async {
    final current = state;
    if (current is! PaymentLoaded) return;

    emit(
      current.copyWith(
        selectedGrade: grade,
        isLoadingPayments: true,
        payments: [],
      ),
    );

    try {
      final payments = await paymentUseCase.getPaymentsForGrade(
        grade: grade,
        month: month,
      );
      final latest = state;
      if (latest is PaymentLoaded) {
        emit(latest.copyWith(payments: payments, isLoadingPayments: false));
      }
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> updateGradePrice({
    required String gradeId,
    required double monthlyAmount,
  }) async {
    final current = state;
    if (current is! PaymentLoaded) return;

    emit(current.copyWith(isSaving: true));
    try {
      await paymentUseCase.updateGradePrice(
        gradeId: gradeId,
        monthlyAmount: monthlyAmount,
      );

      final updatedGrades = current.grades
          .map(
            (g) =>
                g.id == gradeId ? g.copyWith(monthlyAmount: monthlyAmount) : g,
          )
          .toList();

      emit(current.copyWith(grades: updatedGrades, isSaving: false));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> markPaid({
    required String studentId,
    required String teacherId,
    required double amount,
    required DateTime month,
  }) async {
    final current = state;
    if (current is! PaymentLoaded || current.selectedGrade == null) return;

    emit(current.copyWith(isSaving: true));
    try {
      await paymentUseCase.markPaid(
        studentId: studentId,
        month: month,
        teacherId: teacherId,
        amount: amount,
      );

      final updatedPayments = current.payments
          .map(
            (p) => p.studentId == studentId
                ? GradePaymentStatusModel(
                    studentId: p.studentId,
                    studentName: p.studentName,
                    paidThisMonth: true,
                  )
                : p,
          )
          .toList();

      emit(current.copyWith(payments: updatedPayments, isSaving: false));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> markUnpaid({
    required String studentId,
    required DateTime month,
  }) async {
    final current = state;
    if (current is! PaymentLoaded) return;

    emit(current.copyWith(isSaving: true));
    try {
      await paymentUseCase.markUnpaid(studentId: studentId, month: month);

      final updatedPayments = current.payments
          .map(
            (p) => p.studentId == studentId
                ? GradePaymentStatusModel(
                    studentId: p.studentId,
                    studentName: p.studentName,
                    paidThisMonth: false,
                  )
                : p,
          )
          .toList();

      emit(current.copyWith(payments: updatedPayments, isSaving: false));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }
}

sealed class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<Grade> grades;
  final String? selectedGrade;
  final List<GradePaymentStatusModel> payments;
  final bool isLoadingPayments;
  final bool isSaving;

  PaymentLoaded({
    required this.grades,
    this.selectedGrade,
    this.payments = const [],
    this.isLoadingPayments = false,
    this.isSaving = false,
  });

  PaymentLoaded copyWith({
    List<Grade>? grades,
    String? selectedGrade,
    List<GradePaymentStatusModel>? payments,
    bool? isLoadingPayments,
    bool? isSaving,
  }) {
    return PaymentLoaded(
      grades: grades ?? this.grades,
      selectedGrade: selectedGrade ?? this.selectedGrade,
      payments: payments ?? this.payments,
      isLoadingPayments: isLoadingPayments ?? this.isLoadingPayments,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class PaymentError extends PaymentState {
  final String message;

  PaymentError(this.message);
}
