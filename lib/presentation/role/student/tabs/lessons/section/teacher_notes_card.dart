import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/custom_text.dart';

class TeacherNotesCard extends StatelessWidget {
  const TeacherNotesCard({super.key, required this.notes});

  final String notes;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.menu_book_rounded, size: 16, color: Colors.blue),
              const SizedBox(width: 6),
              CustomText(
                text: l10.teacherNotes,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          CustomText(
            text: notes,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
