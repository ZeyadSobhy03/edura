import 'package:flutter/material.dart';

import '../../../../../../../../core/model/attendance_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';


class AttendanceStatusStyle {
  final Color color;
  final IconData icon;
  final String label;

  const AttendanceStatusStyle({
    required this.color,
    required this.icon,
    required this.label,
  });

  static AttendanceStatusStyle of(AttendanceStatus status, AppLocalizations l10) {
    switch (status) {
      case AttendanceStatus.present:
        return AttendanceStatusStyle(
          color: Colors.green,
          icon: Icons.check_circle,
          label: l10.present,
        );
      case AttendanceStatus.absent:
        return AttendanceStatusStyle(
          color: Colors.red,
          icon: Icons.cancel,
          label: l10.absent,
        );
      case AttendanceStatus.late:
        return AttendanceStatusStyle(
          color: Colors.orange,
          icon: Icons.access_time_filled,
          label: l10.late,
        );
    }
  }
}