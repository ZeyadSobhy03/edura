import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../../../../l10n/app_localizations.dart';
import '../../../../teacher_grades/data/model/grade_model.dart';
import '../view_model/payment_view_model.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);

  @override
  void initState() {
    super.initState();
    context.read<PaymentCubit>().getGrades();
  }

  void _changeMonth(int delta, String grade) {
    setState(() => _month = DateTime(_month.year, _month.month + delta));
    context.read<PaymentCubit>().selectGrade(grade, _month);
  }

  void _editPrice(BuildContext context, Grade grade) {
    final l10 = AppLocalizations.of(context)!;
    final controller = TextEditingController(
      text: grade.monthlyAmount.toStringAsFixed(0),
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(l10.setPrice),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: l10.monthlyAmount,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              l10.cancel,
              style: TextStyle(color: ColorManager.black),
            ),
          ),
          TextButton(
            onPressed: () {
              final amount = double.tryParse(controller.text.trim());
              if (amount != null) {
                context.read<PaymentCubit>().updateGradePrice(
                  gradeId: grade.id,
                  monthlyAmount: amount,
                );
              }
              Navigator.pop(dialogContext);
            },
            child: Text(
              l10.save,
              style: TextStyle(color: ColorManager.primary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.payments,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if (state is PaymentLoading || state is PaymentInitial) {
              return Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            }

            if (state is PaymentError) {
              return Center(
                child: CustomText(
                  text: l10.errorOccurred,
                  style: TextStyle(color: ColorManager.red),
                ),
              );
            }

            final loaded = state as PaymentLoaded;

            if (loaded.grades.isEmpty) {
              return Center(
                child: CustomText(
                  text: l10.noGradesFound,
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.5),
                  ),
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CustomText(
                  text: l10.gradePricing,
                  style: TextStyle(
                    color: ColorManager.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),

                ...loaded.grades.map((grade) {
                  final isSelected = loaded.selectedGrade == grade.name;

                  return GestureDetector(
                    onTap: () => context.read<PaymentCubit>().selectGrade(
                      grade.name,
                      _month,
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorManager.primary.withValues(alpha: 0.08)
                            : ColorManager.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? ColorManager.primary
                              : ColorManager.black.withValues(alpha: 0.08),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: grade.name,
                              style: TextStyle(
                                color: ColorManager.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          CustomText(
                            text:
                                '\$${grade.monthlyAmount.toStringAsFixed(0)} /${l10.month}',
                            style: TextStyle(
                              color: ColorManager.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () => _editPrice(context, grade),
                            child: Icon(
                              Icons.edit_outlined,
                              size: 18,
                              color: ColorManager.gray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                if (loaded.selectedGrade != null) ...[
                  const SizedBox(height: 16),
                  Divider(color: ColorManager.gray.withValues(alpha: 0.15)),
                  const SizedBox(height: 12),
                  CustomText(
                    text: '${l10.paymentsFor} ${loaded.selectedGrade}',
                    style: TextStyle(
                      color: ColorManager.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: loaded.isLoadingPayments
                            ? null
                            : () => _changeMonth(-1, loaded.selectedGrade!),
                      ),
                      CustomText(
                        text: DateFormat('MMMM yyyy').format(_month),
                        style: TextStyle(
                          color: ColorManager.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: loaded.isLoadingPayments
                            ? null
                            : () => _changeMonth(1, loaded.selectedGrade!),
                      ),
                    ],
                  ),

                  if (!loaded.isLoadingPayments && loaded.payments.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: CustomText(
                        text:
                            '${loaded.payments.where((p) => p.paidThisMonth).length}'
                            '/${loaded.payments.length} ${l10.paid}',
                        style: TextStyle(
                          color: ColorManager.black.withValues(alpha: 0.5),
                          fontSize: 12,
                        ),
                      ),
                    ),

                  if (loaded.isLoadingPayments)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: CircularProgressIndicator(
                          color: ColorManager.primary,
                        ),
                      ),
                    )
                  else if (loaded.payments.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: CustomText(
                        text: l10.noStudentsFound,
                        style: TextStyle(
                          color: ColorManager.black.withValues(alpha: 0.5),
                        ),
                      ),
                    )
                  else
                    ...loaded.payments.map((payment) {
                      final currentGrade = loaded.grades.firstWhere(
                        (g) => g.name == loaded.selectedGrade,
                      );

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.primary.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                text: payment.studentName,
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: loaded.isSaving
                                  ? null
                                  : () {
                                      final cubit = context
                                          .read<PaymentCubit>();
                                      if (payment.paidThisMonth) {
                                        cubit.markUnpaid(
                                          studentId: payment.studentId,
                                          month: _month,
                                        );
                                      } else {
                                        cubit.markPaid(
                                          studentId: payment.studentId,
                                          teacherId: Supabase
                                              .instance
                                              .client
                                              .auth
                                              .currentUser!
                                              .id,
                                          amount: currentGrade.monthlyAmount,
                                          month: _month,
                                        );
                                      }
                                    },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: payment.paidThisMonth
                                      ? Colors.green.withValues(alpha: 0.15)
                                      : Colors.red.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: CustomText(
                                  text: payment.paidThisMonth
                                      ? l10.paid
                                      : l10.unpaid,
                                  style: TextStyle(
                                    color: payment.paidThisMonth
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
