// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get yourLearningJourney => 'Your Learning Journey';

  @override
  String get edura => 'Edura';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get sinInToContinue => 'Sign in to continue';

  @override
  String get student => 'Student';

  @override
  String get teacher => 'Teacher';

  @override
  String get emailAddress => 'EMAil ADDRESS';

  @override
  String get password => 'PASSWORD';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get forgotPasswordTitle => 'Forgot password';

  @override
  String get forgotPasswordDescription =>
      'Enter your email and we will send you a reset link.';

  @override
  String get enterYourEmail => 'Enter your email';

  @override
  String get enterYourPassword => 'Enter your password';

  @override
  String get login => 'Login';

  @override
  String get or => 'OR';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get dontHaveAnAccount => 'Don\'t have an account?';

  @override
  String get register => 'Register';

  @override
  String get createAnAccount => 'Create an account';

  @override
  String get teacherAccountIssues => 'Teacher account issues';

  @override
  String get contactAdmin => 'Contact Admin';

  @override
  String get fullName => 'Full Name';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get parentPhone => 'Parent Phone';

  @override
  String get school => 'School';

  @override
  String get grade => 'Grade';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get enterYourFullName => 'Enter your full name';

  @override
  String get enterYourPhoneNumber => 'Enter your phone number';

  @override
  String get enterYourParentPhone => 'Enter your parent phone';

  @override
  String get enterYourSchool => 'Enter your school';

  @override
  String get enterYourGrade => 'Enter your grade';

  @override
  String get enterYourConfirmPassword => 'Enter your confirm password';

  @override
  String get email => 'Email';

  @override
  String get alreadyHaveAnAccount => 'Already have an account?';

  @override
  String get resetPassword => 'Reset password';

  @override
  String get backToLogin => 'Back to login';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get lessons => 'Lessons';

  @override
  String get chat => 'Chat';

  @override
  String get exams => 'Exams';

  @override
  String get goodMorning => 'Good Morning';

  @override
  String get goodEvening => 'Good Evening';

  @override
  String get notifications => 'Notifications';

  @override
  String get noNotifications => 'No notifications';

  @override
  String get studyTime => 'Study Time';

  @override
  String get averageScore => 'Average Score';

  @override
  String get upToNextLesson => 'Up to next lesson';

  @override
  String get min => 'min';

  @override
  String get progress => 'Progress';

  @override
  String get continueWatch => 'Continue';

  @override
  String get overview => 'Overview';

  @override
  String get materials => 'Materials';

  @override
  String get notes => 'Notes';

  @override
  String get downloadPdf => 'Download PDF';

  @override
  String get homework => 'Homework';

  @override
  String get noMaterialsFound => 'No materials found';

  @override
  String get personalNotesHint =>
      'Your personal notes appear here. Add notes while watching the video.';

  @override
  String get teacherNotes => 'Teacher Notes';

  @override
  String get writeYourNotes => 'Write your notes.....';

  @override
  String get pending => 'Pending';

  @override
  String get submitted => 'Submitted';

  @override
  String get graded => 'Graded';

  @override
  String get takePhoto => 'Take photo';

  @override
  String get attachPdf => 'Attach PDF';

  @override
  String get noHomework => 'No homework available';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get schedule => 'Schedule';

  @override
  String get searchLessons => 'Search lessons';

  @override
  String get noLessonsFound => 'No lessons found';

  @override
  String get recentLessons => 'Recent Lessons';

  @override
  String get viewAll => 'View All';

  @override
  String get pinned => 'Pinned';

  @override
  String get noAnnouncements => 'No announcements';

  @override
  String get teacherName => 'Teacher Name';

  @override
  String get online => 'Online';

  @override
  String get typeMessage => 'Type Message....';

  @override
  String get noMessages => 'No Message';

  @override
  String get offline => 'Offline';

  @override
  String get announcements => 'Announcements';

  @override
  String get available => 'Available';

  @override
  String get completed => 'Completed';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get locked => 'Locked';

  @override
  String get startExam => 'Start Exam';

  @override
  String get submit => 'Submit';

  @override
  String get next => 'Next';

  @override
  String get rank => 'Rank';

  @override
  String get points => 'Points';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get done => 'Done';

  @override
  String get cancel => 'Cancel';

  @override
  String get achievements => 'Achievements';

  @override
  String get exit => 'Exit';

  @override
  String get exitExamTitle => 'Exit Exam?';

  @override
  String get exitExamDescription =>
      'Your progress will be lost if you exit now.';

  @override
  String questionNumberLabel(Object questionNumber) {
    return 'Question $questionNumber';
  }

  @override
  String currentQuestionProgress(
    Object currentQuestion,
    Object totalQuestions,
  ) {
    return 'Question $currentQuestion of $totalQuestions';
  }

  @override
  String correctAnswersSummary(Object correctCount, Object totalQuestions) {
    return '$correctCount / $totalQuestions correct';
  }

  @override
  String get passed => 'Passed';

  @override
  String get failed => 'Failed';

  @override
  String get noExamsFound => 'No exams found';

  @override
  String get assignments => 'Assignments';

  @override
  String get today => 'Today';

  @override
  String get daysAgo => 'days ago';

  @override
  String get examDetails => 'Exam Details';

  @override
  String get totalScore => 'Total Score';

  @override
  String get instructions => 'Instructions';

  @override
  String get instructionReadCarefully =>
      'Read each question carefully before answering.';

  @override
  String get instructionNoGoingBack =>
      'You cannot go back once a question is submitted.';

  @override
  String get instructionDuration => 'Duration is 90 minutes.';

  @override
  String get instructionStableConnection =>
      'Ensure stable internet connection.';

  @override
  String get instructionAcademicHonesty =>
      'Academic honesty is strictly enforced.';

  @override
  String get requirements => 'Requirements';

  @override
  String get requirementLessons => 'Complete Lesson 1 & 2';

  @override
  String get requirementConnection => 'Stable internet connection';

  @override
  String get requirementQuietEnvironment => 'Quiet environment';

  @override
  String get yesterday => 'Yesterday';

  @override
  String numberOfClassToday(int numberOfClasses) {
    return 'Number of classes today $numberOfClasses ';
  }

  @override
  String numberOfAchievements(int numberOfAchievements) {
    return 'Number of achievements $numberOfAchievements ';
  }

  @override
  String numberOfHomework(int numberOfHomework) {
    return 'Number of homework $numberOfHomework ';
  }

  @override
  String get personalStudyNotes => 'Personal Study Notes';

  @override
  String attendanceScore(int attendanceScore) {
    return ' Attendance Score$attendanceScore';
  }

  @override
  String numberOfAnnouncements(int numberOfAnnouncements) {
    return 'Number of announcements $numberOfAnnouncements ';
  }

  @override
  String get accountSettings => 'Account Settings';

  @override
  String get setting => 'Settings';

  @override
  String get logout => 'Logout';

  @override
  String get classLabel => 'Class';

  @override
  String get lab => 'Lab';

  @override
  String get todaysClasses => 'Today\'s Classes';

  @override
  String get noClassesToday => 'No classes scheduled for this day';

  @override
  String get noLeaderboardData => 'No leaderboard data yet';

  @override
  String get attendance => 'Attendance';

  @override
  String get pts => 'pts';

  @override
  String get newNote => 'New';

  @override
  String get editNote => 'Edit Note';

  @override
  String get save => 'Save';

  @override
  String get noteTitleHint => 'Note title';

  @override
  String get noteContentHint => 'Start writing...';

  @override
  String get noteTitleRequired => 'Please enter a title for your note';

  @override
  String get overallAttendance => 'Overall Attendance';

  @override
  String get present => 'Present';

  @override
  String get absent => 'Absent';

  @override
  String get late => 'Late';

  @override
  String get monthlyTrend => 'Monthly Trend';

  @override
  String get searchNotes => 'Search notes...';

  @override
  String get folders => 'Folders';

  @override
  String get recentNotes => 'Recent Notes';

  @override
  String get settings => 'Settings';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get preferences => 'Preferences';

  @override
  String get language => 'Language';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get emailNotifications => 'Email Notifications';

  @override
  String get account => 'Account';

  @override
  String get changePassword => 'Change Password';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get support => 'Support';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get contactSupport => 'Contact Support';

  @override
  String get about => 'About';

  @override
  String get logoutConfirmation => 'Are you sure you want to log out?';

  @override
  String get nameRequired => 'Please enter your name';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get updatePassword => 'Update Password';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get passwordChangedSuccessfully => 'Password changed successfully';

  @override
  String get searchFaq => 'Search FAQs...';

  @override
  String get noFaqFound => 'No results found';

  @override
  String get howCanWeHelp => 'How can we help you today?';

  @override
  String get liveChat => 'Live Chat';

  @override
  String get liveChatSubtitle => 'Chat with our support team';

  @override
  String get emailSupport => 'Email Support';

  @override
  String get noNotesFound => 'No notes found';

  @override
  String notesCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notes',
      one: '1 note',
    );
    return '$_temp0';
  }

  @override
  String rankAndBadgesSummary(Object count, Object rank) {
    return 'Rank #$rank · $count badges earned';
  }

  @override
  String get questions => 'Questions';
}
