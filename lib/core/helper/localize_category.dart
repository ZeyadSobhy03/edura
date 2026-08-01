import 'package:flutter/cupertino.dart';

import '../../l10n/app_localizations.dart';

class LocalizeCategory {
 static String localizeCategory(String category, BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    switch (category) {
      case "Available":
        return l10.available;
      case "Completed":
        return l10.completed;
      case "Upcoming":
        return l10.upcoming;
      case "Locked":
        return l10.locked;
      default:
        return l10.locked;
    }
  }
}
