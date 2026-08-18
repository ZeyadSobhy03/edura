import 'package:flutter/material.dart';

import '../../../../../../../../core/model/attendance_taking_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class AttendanceMarkStyle {
  final Color color;
  final String label;

  const AttendanceMarkStyle({required this.color, required this.label});

  static AttendanceMarkStyle of(AttendanceMark mark, AppLocalizations l10) {
    switch (mark) {
      case AttendanceMark.present:
        return AttendanceMarkStyle(color: Colors.green, label: l10.present);
      case AttendanceMark.absent:
        return AttendanceMarkStyle(color: Colors.red, label: l10.absent);
      case AttendanceMark.late:
        return AttendanceMarkStyle(color: Colors.orange, label: l10.late);
    }
  }
}
