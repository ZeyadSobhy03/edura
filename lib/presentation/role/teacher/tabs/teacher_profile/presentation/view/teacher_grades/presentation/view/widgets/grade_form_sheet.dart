import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_elevated_button.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/grade_model.dart';

Future<void> showGradeFormSheet({
  required BuildContext context,
  Grade? existing,
  required void Function(String name, double? monthlyAmount) onSubmit,
}) {
  return showModalBottomSheet(
    useSafeArea: true,
    context: context,
    isScrollControlled: true,
    backgroundColor: ColorManager.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: _GradeFormContent(existing: existing, onSubmit: onSubmit),
      );
    },
  );
}

class _GradeFormContent extends StatefulWidget {
  const _GradeFormContent({required this.existing, required this.onSubmit});

  final Grade? existing;
  final void Function(String name, double? monthlyAmount) onSubmit;

  @override
  State<_GradeFormContent> createState() => _GradeFormContentState();
}

class _GradeFormContentState extends State<_GradeFormContent> {
  late final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController = TextEditingController(
    text: widget.existing?.name,
  );
  late final TextEditingController _amountController = TextEditingController(
    text: widget.existing?.monthlyAmount.toStringAsFixed(0),
  );

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.onSubmit(
      _nameController.text.trim(),
      double.tryParse(_amountController.text.trim()),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final isEditing = widget.existing != null;
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: isEditing ? l10.editGrade : l10.addGrade,
              style: TextStyle(
                color: ColorManager.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            CustomText(
              text: l10.gradeName,
              style: TextStyle(color: ColorManager.gray, fontSize: 13),
            ),
            const SizedBox(height: 4),
            CustomTextFormedField(
              hintText: l10.enterGradeName,
              controller: _nameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10.pleaseEnterGradeName;
                }
                return null;
              },
            ),

            const SizedBox(height: 12),
            CustomText(
              text: l10.monthlyAmount,
              style: TextStyle(color: ColorManager.gray, fontSize: 13),
            ),
            const SizedBox(height: 4),
            CustomTextFormedField(
              hintText: l10.enterMonthlyAmount,
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10.pleaseEnterMonthlyAmount;
                }
                if (double.tryParse(value.trim()) == null) {
                  return l10.pleaseEnterValidMonthlyAmount;
                }
                return null;
              },
            ),

            const SizedBox(height: 20),
            CustomElevatedButton(
              text: isEditing ? l10.saveChanges : l10.addGrade,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
