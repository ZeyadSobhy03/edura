import '../../../../../../../../../../l10n/app_localizations.dart';

class AchievementL10n {
  static String localizedTitle(AppLocalizations l10, String codeTitle) {
    switch (codeTitle) {
      case 'first_exam':
        return l10.eachFirstExamTitle;
      case 'high_scorer':
        return l10.eachHighScorerTitle;
      case 'perfect_exam':
        return l10.eachPerfectExamTitle;
      case 'five_lessons':
        return l10.eachFiveLessonsTitle;
      default:
        return codeTitle;
    }
  }

  static String localizedDescription(
    AppLocalizations l10,
    String codeDescription,
  ) {
    switch (codeDescription) {
      case 'first_exam':
        return l10.eachFirstExamDesc;
      case 'high_scorer':
        return l10.eachHighScorerDesc;
      case 'perfect_exam':
        return l10.eachPerfectExamDesc;
      case 'five_lessons':
        return l10.eachFiveLessonsDesc;
      default:
        return codeDescription;
    }
  }
}
