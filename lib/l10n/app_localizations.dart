import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @yourLearningJourney.
  ///
  /// In en, this message translates to:
  /// **'Your Learning Journey'**
  String get yourLearningJourney;

  /// No description provided for @edura.
  ///
  /// In en, this message translates to:
  /// **'Edura'**
  String get edura;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @sinInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get sinInToContinue;

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// No description provided for @teacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get teacher;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'EMAil ADDRESS'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'PASSWORD'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we will send you a reset link.'**
  String get forgotPasswordDescription;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAnAccount;

  /// No description provided for @teacherAccountIssues.
  ///
  /// In en, this message translates to:
  /// **'Teacher account issues'**
  String get teacherAccountIssues;

  /// No description provided for @contactAdmin.
  ///
  /// In en, this message translates to:
  /// **'Contact Admin'**
  String get contactAdmin;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @parentPhone.
  ///
  /// In en, this message translates to:
  /// **'Parent Phone'**
  String get parentPhone;

  /// No description provided for @school.
  ///
  /// In en, this message translates to:
  /// **'School'**
  String get school;

  /// No description provided for @grade.
  ///
  /// In en, this message translates to:
  /// **'Grade'**
  String get grade;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @enterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterYourFullName;

  /// No description provided for @enterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterYourPhoneNumber;

  /// No description provided for @enterYourParentPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter your parent phone'**
  String get enterYourParentPhone;

  /// No description provided for @enterYourSchool.
  ///
  /// In en, this message translates to:
  /// **'Enter your school'**
  String get enterYourSchool;

  /// No description provided for @enterYourGrade.
  ///
  /// In en, this message translates to:
  /// **'Enter your grade'**
  String get enterYourGrade;

  /// No description provided for @enterYourConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your confirm password'**
  String get enterYourConfirmPassword;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get backToLogin;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @lessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get lessons;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @exams.
  ///
  /// In en, this message translates to:
  /// **'Exams'**
  String get exams;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @studyTime.
  ///
  /// In en, this message translates to:
  /// **'Study Time'**
  String get studyTime;

  /// No description provided for @averageScore.
  ///
  /// In en, this message translates to:
  /// **'Average Score'**
  String get averageScore;

  /// No description provided for @upToNextLesson.
  ///
  /// In en, this message translates to:
  /// **'Up to next lesson'**
  String get upToNextLesson;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get min;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @continueWatch.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueWatch;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @materials.
  ///
  /// In en, this message translates to:
  /// **'Materials'**
  String get materials;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @downloadPdf.
  ///
  /// In en, this message translates to:
  /// **'Download PDF'**
  String get downloadPdf;

  /// No description provided for @homework.
  ///
  /// In en, this message translates to:
  /// **'Homework'**
  String get homework;

  /// No description provided for @noMaterialsFound.
  ///
  /// In en, this message translates to:
  /// **'No materials found'**
  String get noMaterialsFound;

  /// No description provided for @personalNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Your personal notes appear here. Add notes while watching the video.'**
  String get personalNotesHint;

  /// No description provided for @teacherNotes.
  ///
  /// In en, this message translates to:
  /// **'Teacher Notes'**
  String get teacherNotes;

  /// No description provided for @writeYourNotes.
  ///
  /// In en, this message translates to:
  /// **'Write your notes.....'**
  String get writeYourNotes;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @submitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get submitted;

  /// No description provided for @graded.
  ///
  /// In en, this message translates to:
  /// **'Graded'**
  String get graded;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get takePhoto;

  /// No description provided for @attachPdf.
  ///
  /// In en, this message translates to:
  /// **'Attach PDF'**
  String get attachPdf;

  /// No description provided for @noHomework.
  ///
  /// In en, this message translates to:
  /// **'No homework available'**
  String get noHomework;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @searchLessons.
  ///
  /// In en, this message translates to:
  /// **'Search lessons'**
  String get searchLessons;

  /// No description provided for @noLessonsFound.
  ///
  /// In en, this message translates to:
  /// **'No lessons found'**
  String get noLessonsFound;

  /// No description provided for @recentLessons.
  ///
  /// In en, this message translates to:
  /// **'Recent Lessons'**
  String get recentLessons;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @pinned.
  ///
  /// In en, this message translates to:
  /// **'Pinned'**
  String get pinned;

  /// No description provided for @noAnnouncements.
  ///
  /// In en, this message translates to:
  /// **'No announcements'**
  String get noAnnouncements;

  /// No description provided for @teacherName.
  ///
  /// In en, this message translates to:
  /// **'Teacher Name'**
  String get teacherName;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type Message....'**
  String get typeMessage;

  /// No description provided for @noMessages.
  ///
  /// In en, this message translates to:
  /// **'No Message'**
  String get noMessages;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @announcements.
  ///
  /// In en, this message translates to:
  /// **'Announcements'**
  String get announcements;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @startExam.
  ///
  /// In en, this message translates to:
  /// **'Start Exam'**
  String get startExam;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @rank.
  ///
  /// In en, this message translates to:
  /// **'Rank'**
  String get rank;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @leaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboard;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @exitExamTitle.
  ///
  /// In en, this message translates to:
  /// **'Exit Exam?'**
  String get exitExamTitle;

  /// No description provided for @exitExamDescription.
  ///
  /// In en, this message translates to:
  /// **'Your progress will be lost if you exit now.'**
  String get exitExamDescription;

  /// No description provided for @questionNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Question {questionNumber}'**
  String questionNumberLabel(Object questionNumber);

  /// No description provided for @currentQuestionProgress.
  ///
  /// In en, this message translates to:
  /// **'Question {currentQuestion} of {totalQuestions}'**
  String currentQuestionProgress(Object currentQuestion, Object totalQuestions);

  /// No description provided for @correctAnswersSummary.
  ///
  /// In en, this message translates to:
  /// **'{correctCount} / {totalQuestions} correct'**
  String correctAnswersSummary(Object correctCount, Object totalQuestions);

  /// No description provided for @passed.
  ///
  /// In en, this message translates to:
  /// **'Passed'**
  String get passed;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @noExamsFound.
  ///
  /// In en, this message translates to:
  /// **'No exams found'**
  String get noExamsFound;

  /// No description provided for @assignments.
  ///
  /// In en, this message translates to:
  /// **'Assignments'**
  String get assignments;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @examDetails.
  ///
  /// In en, this message translates to:
  /// **'Exam Details'**
  String get examDetails;

  /// No description provided for @totalScore.
  ///
  /// In en, this message translates to:
  /// **'Total Score'**
  String get totalScore;

  /// No description provided for @instructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructions;

  /// No description provided for @instructionReadCarefully.
  ///
  /// In en, this message translates to:
  /// **'Read each question carefully before answering.'**
  String get instructionReadCarefully;

  /// No description provided for @instructionNoGoingBack.
  ///
  /// In en, this message translates to:
  /// **'You cannot go back once a question is submitted.'**
  String get instructionNoGoingBack;

  /// No description provided for @instructionDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration is 90 minutes.'**
  String get instructionDuration;

  /// No description provided for @instructionStableConnection.
  ///
  /// In en, this message translates to:
  /// **'Ensure stable internet connection.'**
  String get instructionStableConnection;

  /// No description provided for @instructionAcademicHonesty.
  ///
  /// In en, this message translates to:
  /// **'Academic honesty is strictly enforced.'**
  String get instructionAcademicHonesty;

  /// No description provided for @requirements.
  ///
  /// In en, this message translates to:
  /// **'Requirements'**
  String get requirements;

  /// No description provided for @requirementLessons.
  ///
  /// In en, this message translates to:
  /// **'Complete Lesson 1 & 2'**
  String get requirementLessons;

  /// No description provided for @requirementConnection.
  ///
  /// In en, this message translates to:
  /// **'Stable internet connection'**
  String get requirementConnection;

  /// No description provided for @requirementQuietEnvironment.
  ///
  /// In en, this message translates to:
  /// **'Quiet environment'**
  String get requirementQuietEnvironment;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @numberOfClassToday.
  ///
  /// In en, this message translates to:
  /// **'Number of classes today {numberOfClasses} '**
  String numberOfClassToday(int numberOfClasses);

  /// No description provided for @numberOfAchievements.
  ///
  /// In en, this message translates to:
  /// **'Number of achievements {numberOfAchievements} '**
  String numberOfAchievements(int numberOfAchievements);

  /// No description provided for @numberOfHomework.
  ///
  /// In en, this message translates to:
  /// **'Number of homework {numberOfHomework} '**
  String numberOfHomework(int numberOfHomework);

  /// No description provided for @personalStudyNotes.
  ///
  /// In en, this message translates to:
  /// **'Personal Study Notes'**
  String get personalStudyNotes;

  /// No description provided for @attendanceScore.
  ///
  /// In en, this message translates to:
  /// **' Attendance Score{attendanceScore}'**
  String attendanceScore(int attendanceScore);

  /// No description provided for @numberOfAnnouncements.
  ///
  /// In en, this message translates to:
  /// **'Number of announcements {numberOfAnnouncements} '**
  String numberOfAnnouncements(int numberOfAnnouncements);

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get setting;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @classLabel.
  ///
  /// In en, this message translates to:
  /// **'Class'**
  String get classLabel;

  /// No description provided for @lab.
  ///
  /// In en, this message translates to:
  /// **'Lab'**
  String get lab;

  /// No description provided for @todaysClasses.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Classes'**
  String get todaysClasses;

  /// No description provided for @noClassesToday.
  ///
  /// In en, this message translates to:
  /// **'No classes scheduled for this day'**
  String get noClassesToday;

  /// No description provided for @noLeaderboardData.
  ///
  /// In en, this message translates to:
  /// **'No leaderboard data yet'**
  String get noLeaderboardData;

  /// No description provided for @attendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendance;

  /// No description provided for @pts.
  ///
  /// In en, this message translates to:
  /// **'pts'**
  String get pts;

  /// No description provided for @newNote.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newNote;

  /// No description provided for @editNote.
  ///
  /// In en, this message translates to:
  /// **'Edit Note'**
  String get editNote;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @noteTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Note title'**
  String get noteTitleHint;

  /// No description provided for @noteContentHint.
  ///
  /// In en, this message translates to:
  /// **'Start writing...'**
  String get noteContentHint;

  /// No description provided for @noteTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title for your note'**
  String get noteTitleRequired;

  /// No description provided for @overallAttendance.
  ///
  /// In en, this message translates to:
  /// **'Overall Attendance'**
  String get overallAttendance;

  /// No description provided for @present.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get present;

  /// No description provided for @absent.
  ///
  /// In en, this message translates to:
  /// **'Absent'**
  String get absent;

  /// No description provided for @late.
  ///
  /// In en, this message translates to:
  /// **'Late'**
  String get late;

  /// No description provided for @monthlyTrend.
  ///
  /// In en, this message translates to:
  /// **'Monthly Trend'**
  String get monthlyTrend;

  /// No description provided for @searchNotes.
  ///
  /// In en, this message translates to:
  /// **'Search notes...'**
  String get searchNotes;

  /// No description provided for @folders.
  ///
  /// In en, this message translates to:
  /// **'Folders'**
  String get folders;

  /// No description provided for @recentNotes.
  ///
  /// In en, this message translates to:
  /// **'Recent Notes'**
  String get recentNotes;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @emailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get emailNotifications;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirmation;

  /// No description provided for @sendNotification.
  ///
  /// In en, this message translates to:
  /// **'Send Notification'**
  String get sendNotification;

  /// No description provided for @audience.
  ///
  /// In en, this message translates to:
  /// **'Audience'**
  String get audience;

  /// No description provided for @allStudents.
  ///
  /// In en, this message translates to:
  /// **'All Students'**
  String get allStudents;

  /// No description provided for @activeOnly.
  ///
  /// In en, this message translates to:
  /// **'Active Only'**
  String get activeOnly;

  /// No description provided for @individual.
  ///
  /// In en, this message translates to:
  /// **'Individual'**
  String get individual;

  /// No description provided for @selectStudents.
  ///
  /// In en, this message translates to:
  /// **'Select students'**
  String get selectStudents;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification Title'**
  String get notificationTitle;

  /// No description provided for @notificationTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Updated Class Schedule'**
  String get notificationTitleHint;

  /// No description provided for @messageBody.
  ///
  /// In en, this message translates to:
  /// **'Message Body'**
  String get messageBody;

  /// No description provided for @messageBodyHint.
  ///
  /// In en, this message translates to:
  /// **'Write your announcement...'**
  String get messageBodyHint;

  /// No description provided for @pinAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'Pin Announcement'**
  String get pinAnnouncement;

  /// No description provided for @pinAnnouncementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Always visible at the top'**
  String get pinAnnouncementSubtitle;

  /// No description provided for @sendNotificationButton.
  ///
  /// In en, this message translates to:
  /// **'Send Notification'**
  String get sendNotificationButton;

  /// No description provided for @notificationSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Notification sent successfully'**
  String get notificationSentSuccessfully;

  /// No description provided for @totalOfStudents.
  ///
  /// In en, this message translates to:
  /// **'Total of students'**
  String get totalOfStudents;

  /// No description provided for @totalNumberOfStudents.
  ///
  /// In en, this message translates to:
  /// **'Total number of students {totalNumberOfStudents} '**
  String totalNumberOfStudents(int totalNumberOfStudents);

  /// No description provided for @activeStudents.
  ///
  /// In en, this message translates to:
  /// **'Active Students'**
  String get activeStudents;

  /// No description provided for @totalNumberOfActiveStudents.
  ///
  /// In en, this message translates to:
  /// **'Total number of active students {totalNumberOfActiveStudents} '**
  String totalNumberOfActiveStudents(int totalNumberOfActiveStudents);

  /// No description provided for @revenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get revenue;

  /// No description provided for @totalRevenue.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue {totalRevenue} '**
  String totalRevenue(int totalRevenue);

  /// No description provided for @totalNumberOfTodaysClasses.
  ///
  /// In en, this message translates to:
  /// **'Total number of today\'s classes {totalNumberOfTodaysClasses} '**
  String totalNumberOfTodaysClasses(int totalNumberOfTodaysClasses);

  /// No description provided for @studentGrowth.
  ///
  /// In en, this message translates to:
  /// **'Student Growth'**
  String get studentGrowth;

  /// No description provided for @last7Weeks.
  ///
  /// In en, this message translates to:
  /// **'Last 7 weeks'**
  String get last7Weeks;

  /// No description provided for @viewAnalytics.
  ///
  /// In en, this message translates to:
  /// **'View Analytics'**
  String get viewAnalytics;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @totalStudents.
  ///
  /// In en, this message translates to:
  /// **'Total Students'**
  String get totalStudents;

  /// No description provided for @avgScore.
  ///
  /// In en, this message translates to:
  /// **'Avg Score'**
  String get avgScore;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @weeklyEnrollments.
  ///
  /// In en, this message translates to:
  /// **'Weekly enrollments'**
  String get weeklyEnrollments;

  /// No description provided for @monthlyRevenue.
  ///
  /// In en, this message translates to:
  /// **'Monthly Revenue'**
  String get monthlyRevenue;

  /// No description provided for @last4Months.
  ///
  /// In en, this message translates to:
  /// **'Last 4 months'**
  String get last4Months;

  /// No description provided for @lessonCompletion.
  ///
  /// In en, this message translates to:
  /// **'Lesson Completion'**
  String get lessonCompletion;

  /// No description provided for @attendanceRate.
  ///
  /// In en, this message translates to:
  /// **'Attendance Rate'**
  String get attendanceRate;

  /// No description provided for @dailyAttendance.
  ///
  /// In en, this message translates to:
  /// **'Daily Attendance'**
  String get dailyAttendance;

  /// No description provided for @examPerformance.
  ///
  /// In en, this message translates to:
  /// **'Exam Performance'**
  String get examPerformance;

  /// No description provided for @avg.
  ///
  /// In en, this message translates to:
  /// **'avg'**
  String get avg;

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @addLesson.
  ///
  /// In en, this message translates to:
  /// **'Add Lesson'**
  String get addLesson;

  /// No description provided for @createExam.
  ///
  /// In en, this message translates to:
  /// **'Create Exam'**
  String get createExam;

  /// No description provided for @notify.
  ///
  /// In en, this message translates to:
  /// **'Notify'**
  String get notify;

  /// No description provided for @addNewLesson.
  ///
  /// In en, this message translates to:
  /// **'Add New Lesson'**
  String get addNewLesson;

  /// No description provided for @lessonTitle.
  ///
  /// In en, this message translates to:
  /// **'Lesson Title'**
  String get lessonTitle;

  /// No description provided for @lessonTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Introduction to Calculus'**
  String get lessonTitleHint;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @durationHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 45 min'**
  String get durationHint;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'What will students learn in this lesson?'**
  String get descriptionHint;

  /// No description provided for @premiumContent.
  ///
  /// In en, this message translates to:
  /// **'Premium Content'**
  String get premiumContent;

  /// No description provided for @premiumContentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Only paid subscribers can access'**
  String get premiumContentSubtitle;

  /// No description provided for @nextUploadVideo.
  ///
  /// In en, this message translates to:
  /// **'Next: Upload Video'**
  String get nextUploadVideo;

  /// No description provided for @uploadVideo.
  ///
  /// In en, this message translates to:
  /// **'Upload Video'**
  String get uploadVideo;

  /// No description provided for @uploadVideoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'MP4, MOV Â· Max 2GB'**
  String get uploadVideoSubtitle;

  /// No description provided for @chooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose File'**
  String get chooseFile;

  /// No description provided for @processingTime.
  ///
  /// In en, this message translates to:
  /// **'Processing Time'**
  String get processingTime;

  /// No description provided for @processingTimeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Videos are transcoded for all device qualities. Usually takes 5-20 minutes.'**
  String get processingTimeSubtitle;

  /// No description provided for @nextAddPdfs.
  ///
  /// In en, this message translates to:
  /// **'Next: Add PDFs'**
  String get nextAddPdfs;

  /// No description provided for @uploadPdf.
  ///
  /// In en, this message translates to:
  /// **'Upload PDF'**
  String get uploadPdf;

  /// No description provided for @uploadPdfSubtitle.
  ///
  /// In en, this message translates to:
  /// **'PDF Â· Max 50MB'**
  String get uploadPdfSubtitle;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get video;

  /// No description provided for @pdfs.
  ///
  /// In en, this message translates to:
  /// **'PDFs'**
  String get pdfs;

  /// No description provided for @questionBuilder.
  ///
  /// In en, this message translates to:
  /// **'Question Builder'**
  String get questionBuilder;

  /// No description provided for @questionNumber.
  ///
  /// In en, this message translates to:
  /// **'Question {number}'**
  String questionNumber(int number);

  /// No description provided for @enterYourQuestion.
  ///
  /// In en, this message translates to:
  /// **'Enter your question...'**
  String get enterYourQuestion;

  /// No description provided for @optionsSelectCorrectAnswer.
  ///
  /// In en, this message translates to:
  /// **'OPTIONS (select correct answer)'**
  String get optionsSelectCorrectAnswer;

  /// No description provided for @optionHint.
  ///
  /// In en, this message translates to:
  /// **'Option {label}...'**
  String optionHint(String label);

  /// No description provided for @addQuestion.
  ///
  /// In en, this message translates to:
  /// **'Add Question'**
  String get addQuestion;

  /// No description provided for @publishExam.
  ///
  /// In en, this message translates to:
  /// **'Publish Exam ({count} Questions)'**
  String publishExam(int count);

  /// No description provided for @completeAllQuestionsBeforePublishing.
  ///
  /// In en, this message translates to:
  /// **'Please complete all questions and select correct answers before publishing'**
  String get completeAllQuestionsBeforePublishing;

  /// No description provided for @examPublishedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Exam published successfully'**
  String get examPublishedSuccessfully;

  /// No description provided for @saveAttendanceCount.
  ///
  /// In en, this message translates to:
  /// **'Save Attendance ({count} students)'**
  String saveAttendanceCount(int count);

  /// No description provided for @attendanceSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Attendance saved successfully'**
  String get attendanceSavedSuccessfully;

  /// No description provided for @publishLesson.
  ///
  /// In en, this message translates to:
  /// **'Publish Lesson'**
  String get publishLesson;

  /// No description provided for @students.
  ///
  /// In en, this message translates to:
  /// **'Students'**
  String get students;

  /// No description provided for @searchStudents.
  ///
  /// In en, this message translates to:
  /// **'Search students...'**
  String get searchStudents;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @blocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get blocked;

  /// No description provided for @studentDetails.
  ///
  /// In en, this message translates to:
  /// **'Student Details'**
  String get studentDetails;

  /// No description provided for @lessonProgress.
  ///
  /// In en, this message translates to:
  /// **'Lesson Progress'**
  String get lessonProgress;

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Info'**
  String get contactInfo;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @recentActivities.
  ///
  /// In en, this message translates to:
  /// **'Recent Activities'**
  String get recentActivities;

  /// No description provided for @whatsappNotInstalled.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp is not installed on this device'**
  String get whatsappNotInstalled;

  /// No description provided for @published.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get published;

  /// No description provided for @draft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get draft;

  /// No description provided for @publish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get publish;

  /// No description provided for @editLesson.
  ///
  /// In en, this message translates to:
  /// **'Edit Lesson'**
  String get editLesson;

  /// No description provided for @changeThumbnail.
  ///
  /// In en, this message translates to:
  /// **'Change Thumbnail'**
  String get changeThumbnail;

  /// No description provided for @changeVideo.
  ///
  /// In en, this message translates to:
  /// **'Change Video'**
  String get changeVideo;

  /// No description provided for @changePdfs.
  ///
  /// In en, this message translates to:
  /// **'Change PDFs'**
  String get changePdfs;

  /// No description provided for @enterLessonTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter lesson title'**
  String get enterLessonTitle;

  /// No description provided for @lessonDescription.
  ///
  /// In en, this message translates to:
  /// **'Lesson Description'**
  String get lessonDescription;

  /// No description provided for @enterLessonDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter lesson description'**
  String get enterLessonDescription;

  /// No description provided for @reviewHomework.
  ///
  /// In en, this message translates to:
  /// **'Review Homework'**
  String get reviewHomework;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @pdfPreview.
  ///
  /// In en, this message translates to:
  /// **'PDF Preview'**
  String get pdfPreview;

  /// No description provided for @gradeOutOf100.
  ///
  /// In en, this message translates to:
  /// **'GRADE (out of 100)'**
  String get gradeOutOf100;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'FEEDBACK'**
  String get feedback;

  /// No description provided for @feedbackHint.
  ///
  /// In en, this message translates to:
  /// **'Add feedback for the student...'**
  String get feedbackHint;

  /// No description provided for @submitGrade.
  ///
  /// In en, this message translates to:
  /// **'Submit Grade'**
  String get submitGrade;

  /// No description provided for @enterAValidGrade.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid grade'**
  String get enterAValidGrade;

  /// No description provided for @publishedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This lesson is visible to students'**
  String get publishedSubtitle;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @deleteLesson.
  ///
  /// In en, this message translates to:
  /// **'Delete Lesson'**
  String get deleteLesson;

  /// No description provided for @pendingReview.
  ///
  /// In en, this message translates to:
  /// **'Pending Review'**
  String get pendingReview;

  /// No description provided for @submissions.
  ///
  /// In en, this message translates to:
  /// **'Submissions'**
  String get submissions;

  /// No description provided for @tapToReviewAndGrade.
  ///
  /// In en, this message translates to:
  /// **'Tap to Review & Grade'**
  String get tapToReviewAndGrade;

  /// No description provided for @gradeValue.
  ///
  /// In en, this message translates to:
  /// **'Grade: {grade}/100'**
  String gradeValue(int grade);

  /// Shows how many days ago something happened
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String daysAgo(int count);

  /// Shows how many hours ago something happened
  ///
  /// In en, this message translates to:
  /// **'{count} hours ago'**
  String hoursAgo(int count);

  /// Shows how many minutes ago something happened
  ///
  /// In en, this message translates to:
  /// **'{count} minutes ago'**
  String minutesAgo(int count);

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @noSubmissionsYet.
  ///
  /// In en, this message translates to:
  /// **'No submissions yet'**
  String get noSubmissionsYet;

  /// No description provided for @gradeCannotExceed100.
  ///
  /// In en, this message translates to:
  /// **'Grade cannot exceed 100'**
  String get gradeCannotExceed100;

  /// No description provided for @gradeSubmittedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Grade submitted successfully'**
  String get gradeSubmittedSuccessfully;

  /// No description provided for @views.
  ///
  /// In en, this message translates to:
  /// **'Views'**
  String get views;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @chats.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get chats;

  /// No description provided for @searchChats.
  ///
  /// In en, this message translates to:
  /// **'Search chats...'**
  String get searchChats;

  /// No description provided for @noConversationsYet.
  ///
  /// In en, this message translates to:
  /// **'No conversations yet'**
  String get noConversationsYet;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get years;

  /// No description provided for @accountPreferences.
  ///
  /// In en, this message translates to:
  /// **'Account Preferences'**
  String get accountPreferences;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @subjectRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your subject'**
  String get subjectRequired;

  /// No description provided for @yearsOfExperience.
  ///
  /// In en, this message translates to:
  /// **'Years of Experience'**
  String get yearsOfExperience;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullName;

  /// No description provided for @enterSubject.
  ///
  /// In en, this message translates to:
  /// **'Enter your subject'**
  String get enterSubject;

  /// No description provided for @enterYearsOfExperience.
  ///
  /// In en, this message translates to:
  /// **'Enter your years of experience'**
  String get enterYearsOfExperience;

  /// No description provided for @mySubjectsAndClasses.
  ///
  /// In en, this message translates to:
  /// **'My Subjects & Classes'**
  String get mySubjectsAndClasses;

  /// No description provided for @studentMessageAlerts.
  ///
  /// In en, this message translates to:
  /// **'Student Message Alerts'**
  String get studentMessageAlerts;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @earningsAndPayouts.
  ///
  /// In en, this message translates to:
  /// **'Earnings & Payouts'**
  String get earningsAndPayouts;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get paymentMethods;

  /// No description provided for @classSummary.
  ///
  /// In en, this message translates to:
  /// **'{classes} classes Â· {students} students'**
  String classSummary(int classes, int students);

  /// No description provided for @addSubject.
  ///
  /// In en, this message translates to:
  /// **'Add Subject'**
  String get addSubject;

  /// No description provided for @editSubject.
  ///
  /// In en, this message translates to:
  /// **'Edit Subject'**
  String get editSubject;

  /// No description provided for @subjectNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Mathematics'**
  String get subjectNameHint;

  /// No description provided for @noSubjectsYet.
  ///
  /// In en, this message translates to:
  /// **'No subjects added yet'**
  String get noSubjectsYet;

  /// No description provided for @studentsAndRatingAreComputed.
  ///
  /// In en, this message translates to:
  /// **'Students count and rating are calculated automatically and can\'t be edited here.'**
  String get studentsAndRatingAreComputed;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @noPublishedLessons.
  ///
  /// In en, this message translates to:
  /// **'No published lessons'**
  String get noPublishedLessons;

  /// No description provided for @noDraftLessons.
  ///
  /// In en, this message translates to:
  /// **'No draft lessons'**
  String get noDraftLessons;

  /// No description provided for @alertParent.
  ///
  /// In en, this message translates to:
  /// **'Alert Parent'**
  String get alertParent;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @examAvgAndPassRate.
  ///
  /// In en, this message translates to:
  /// **'Avg: {avg}% Â· Pass rate: {passRate}%'**
  String examAvgAndPassRate(String avg, String passRate);

  /// No description provided for @saveAsDraft.
  ///
  /// In en, this message translates to:
  /// **'Save as Draft'**
  String get saveAsDraft;

  /// No description provided for @lessonPublishedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Lesson published successfully'**
  String get lessonPublishedSuccessfully;

  /// No description provided for @lessonSavedAsDraft.
  ///
  /// In en, this message translates to:
  /// **'Lesson saved as draft'**
  String get lessonSavedAsDraft;

  /// No description provided for @passRate.
  ///
  /// In en, this message translates to:
  /// **'Pass rate: {rate}%'**
  String passRate(String rate);

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get nameRequired;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangedSuccessfully;

  /// No description provided for @searchFaq.
  ///
  /// In en, this message translates to:
  /// **'Search FAQs...'**
  String get searchFaq;

  /// No description provided for @noFaqFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noFaqFound;

  /// No description provided for @howCanWeHelp.
  ///
  /// In en, this message translates to:
  /// **'How can we help you today?'**
  String get howCanWeHelp;

  /// No description provided for @liveChat.
  ///
  /// In en, this message translates to:
  /// **'Live Chat'**
  String get liveChat;

  /// No description provided for @liveChatSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Chat with our support team'**
  String get liveChatSubtitle;

  /// No description provided for @emailSupport.
  ///
  /// In en, this message translates to:
  /// **'Email Support'**
  String get emailSupport;

  /// No description provided for @noNotesFound.
  ///
  /// In en, this message translates to:
  /// **'No notes found'**
  String get noNotesFound;

  /// No description provided for @notesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 note} other{{count} notes}}'**
  String notesCount(num count);

  /// No description provided for @rankAndBadgesSummary.
  ///
  /// In en, this message translates to:
  /// **'Rank #{rank} Â· {count} badges earned'**
  String rankAndBadgesSummary(Object count, Object rank);

  /// No description provided for @questions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get questions;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get invalidCredentials;

  /// No description provided for @emailNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your email before logging in.'**
  String get emailNotConfirmed;

  /// No description provided for @emailAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists.'**
  String get emailAlreadyExists;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'The password is too weak. Please choose a stronger password.'**
  String get weakPassword;

  /// No description provided for @tooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many login attempts. Please try again later.'**
  String get tooManyRequests;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please sign in again.'**
  String get sessionExpired;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection.'**
  String get networkError;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your network.'**
  String get noInternet;

  /// No description provided for @timeoutError.
  ///
  /// In en, this message translates to:
  /// **'The request timed out. Please try again.'**
  String get timeoutError;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get serverError;

  /// No description provided for @serviceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The service is temporarily unavailable. Please try again later.'**
  String get serviceUnavailable;

  /// No description provided for @unknownServerError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong on the server. Please try again.'**
  String get unknownServerError;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'The email address is invalid. Please check it and try again.'**
  String get invalidEmail;

  /// No description provided for @emptyField.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get emptyField;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordMismatch;

  /// No description provided for @messageLoginSuccess.
  ///
  /// In en, this message translates to:
  /// **'You have successfully logged in.'**
  String get messageLoginSuccess;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get errorMessage;

  /// No description provided for @messageLoginLoading.
  ///
  /// In en, this message translates to:
  /// **'Logging in, please wait...'**
  String get messageLoginLoading;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required.'**
  String get emailRequired;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'The password you entered is incorrect.'**
  String get wrongPassword;

  /// No description provided for @fileSelectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to select file. Please try again.'**
  String get fileSelectionFailed;

  /// No description provided for @examPublishFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to publish exam. Please check your questions and try again.'**
  String get examPublishFailed;

  /// No description provided for @examPublishing.
  ///
  /// In en, this message translates to:
  /// **'Publishing exam, please wait...'**
  String get examPublishing;

  /// No description provided for @examTitle.
  ///
  /// In en, this message translates to:
  /// **'Exam Title'**
  String get examTitle;

  /// No description provided for @enterExamTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your exam title'**
  String get enterExamTitle;

  /// No description provided for @examTitleCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Exam title cannot be empty.'**
  String get examTitleCannotBeEmpty;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required.'**
  String get passwordRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get emailInvalid;

  /// No description provided for @passwordInvalid.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long.'**
  String get passwordInvalid;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'No account found with this email.'**
  String get userNotFound;

  /// No description provided for @examSubject.
  ///
  /// In en, this message translates to:
  /// **'Exam Subject'**
  String get examSubject;

  /// No description provided for @enterExamSubject.
  ///
  /// In en, this message translates to:
  /// **'Enter your exam subject'**
  String get enterExamSubject;

  /// No description provided for @examSubjectCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Exam subject cannot be empty.'**
  String get examSubjectCannotBeEmpty;

  /// No description provided for @examDuration.
  ///
  /// In en, this message translates to:
  /// **'Exam Duration'**
  String get examDuration;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @pleaseEnterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name.'**
  String get pleaseEnterYourFullName;

  /// No description provided for @pleaseEnterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number.'**
  String get pleaseEnterYourPhoneNumber;

  /// No description provided for @pleaseEnterYourParentPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter your parent phone.'**
  String get pleaseEnterYourParentPhone;

  /// No description provided for @pleaseEnterYourSchool.
  ///
  /// In en, this message translates to:
  /// **'Please enter your school.'**
  String get pleaseEnterYourSchool;

  /// No description provided for @pleaseEnterYourGrade.
  ///
  /// In en, this message translates to:
  /// **'Please enter your grade.'**
  String get pleaseEnterYourGrade;

  /// No description provided for @pleaseEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email.'**
  String get pleaseEnterYourEmail;

  /// No description provided for @pleaseEnterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password.'**
  String get pleaseEnterYourPassword;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get pleaseEnterValidEmail;

  /// No description provided for @pleaseEnterValidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number.'**
  String get pleaseEnterValidPhoneNumber;

  /// No description provided for @registering.
  ///
  /// In en, this message translates to:
  /// **'Registering, please wait...'**
  String get registering;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'You have successfully registered.'**
  String get registerSuccess;

  /// No description provided for @registerFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed. Please try again.'**
  String get registerFailed;

  /// No description provided for @availabilityWindow.
  ///
  /// In en, this message translates to:
  /// **'AVAILABILITY WINDOW'**
  String get availabilityWindow;

  /// No description provided for @endDateMustBeAfterStartDate.
  ///
  /// In en, this message translates to:
  /// **'End date must be after start date'**
  String get endDateMustBeAfterStartDate;

  /// No description provided for @selectStartAndEndDate.
  ///
  /// In en, this message translates to:
  /// **'Please select both start and end dates'**
  String get selectStartAndEndDate;

  /// No description provided for @enterExamDuration.
  ///
  /// In en, this message translates to:
  /// **'Enter exam duration in minutes'**
  String get enterExamDuration;

  /// No description provided for @examDurationCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Exam duration cannot be empty.'**
  String get examDurationCannotBeEmpty;

  /// No description provided for @examDurationMustBeANumber.
  ///
  /// In en, this message translates to:
  /// **'Exam duration must be a number.'**
  String get examDurationMustBeANumber;

  /// No description provided for @unauthorized.
  ///
  /// In en, this message translates to:
  /// **'You are not authorized to perform this action.'**
  String get unauthorized;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
