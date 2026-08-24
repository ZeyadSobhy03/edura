import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/model/subject_class_model.dart';
import '../../../../../../../l10n/app_localizations.dart';


class SubjectClassCard extends StatelessWidget {
  const SubjectClassCard({
    super.key,
    required this.subject,
    required this.onEdit,
    required this.onDelete,
  });

  final SubjectClassModel subject;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.menu_book_outlined, color: ColorManager.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: subject.subjectName,
                  style: TextStyle(color: ColorManager.black, fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                CustomText(
                  text: l10.classSummary(subject.activeClasses, subject.studentsCount),
                  style: TextStyle(color: ColorManager.black.withValues(alpha: 0.5), fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_outlined, size: 18, color: ColorManager.black.withValues(alpha: 0.5)),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}