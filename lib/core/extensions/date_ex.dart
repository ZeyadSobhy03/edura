import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension DateEx on DateTime {
  String get period {
    return hour < 12 ? 'AM' : 'PM';
  }

  String get formatDate {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/${year.toString()}';
  }

  String timeAgo(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 0) {
      return l10.daysAgo(difference.inDays);
    } else if (difference.inHours > 0) {
      return l10.hoursAgo(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return l10.minutesAgo(difference.inMinutes);
    } else {
      return l10.justNow;
    }
  }
}
