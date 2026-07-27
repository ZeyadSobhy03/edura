import 'package:edura/l10n/app_localizations.dart';

import '../../model/homework_model.dart';

class StatusLocalization {
   static String getStatusText(HomeworkStatus status, AppLocalizations l10) {
    switch (status) {
      case HomeworkStatus.pending:
        return l10.pending;
      case HomeworkStatus.submitted:
        return l10.submitted;
      case HomeworkStatus.graded:
        return l10.graded;
    }
  }
}
