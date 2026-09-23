import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/grade_model.dart';

class GradeListTile extends StatelessWidget {
  const GradeListTile({
    super.key,
    required this.grade,
    required this.onEdit,
    required this.onDelete,
  });

  final Grade grade;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorManager.gray.withValues(alpha: .25)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: grade.name,
                  style: TextStyle(
                    color: ColorManager.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                CustomText(
                  text:
                      '${grade.monthlyAmount.toStringAsFixed(0)} / ${l10.month}',
                  style: TextStyle(color: ColorManager.gray, fontSize: 13),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.edit_outlined,
              color: ColorManager.primary,
              size: 20,
            ),
            onPressed: onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: ColorManager.red, size: 20),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
