import 'package:flutter/cupertino.dart';

import '../../../l10n/app_localizations.dart';

class TimeLocalization {


  String get dateFormat => 'dd/MM/yyyy';
  String localizeTime(DateTime time, BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays == 0) {
      return l10.today;
    } else if (difference.inDays == 1) {
      return l10.yesterday;
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${l10.daysAgo}';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }


}