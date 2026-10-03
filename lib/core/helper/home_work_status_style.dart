import 'dart:ui';

import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/l10n/app_localizations.dart';

// enum HomeworkStatus { pending, submitted, graded }
class HomeWorkStatusStyle {
  final Color color;
  final String label;

  HomeWorkStatusStyle({required this.color, required this.label});

  static String getLabelForStatus(String status, AppLocalizations l10) {
    switch (status) {
      case 'published':
        return l10.published;
      case 'submitted':
        return l10.submitted;
      case 'graded':
        return l10.graded;
      default:
        return l10.unknown;
    }
  }

  static Color getColorForStatus(String status) {
    switch (status) {
      case 'published':
        return ColorManager.orange;
      case 'Submitted':
        return ColorManager.blue;
      case 'Graded':
        return ColorManager.green;
      default:
        return ColorManager.gray.withValues(alpha: 0.5);
    }
  }
}
