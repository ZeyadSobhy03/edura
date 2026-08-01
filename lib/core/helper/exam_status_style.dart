import 'package:flutter/material.dart';

import '../../../../../../core/model/exam_model.dart';
import '../../../../../../l10n/app_localizations.dart';

class ExamStatusStyle {
  final Color color;
  final String label;

  const ExamStatusStyle({required this.color, required this.label});

  static ExamStatusStyle of(ExamStatus status, AppLocalizations l10) {
    switch (status) {
      case ExamStatus.available:
        return ExamStatusStyle(color: Colors.blue, label: l10.available);
      case ExamStatus.completed:
        return ExamStatusStyle(color: Colors.green, label: l10.completed);
      case ExamStatus.upcoming:
        return ExamStatusStyle(color: Colors.orange, label: l10.upcoming);
      case ExamStatus.locked:
        return ExamStatusStyle(color: Colors.grey, label: l10.locked);
    }
  }
}