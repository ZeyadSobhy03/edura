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
  String get sendNotification => 'Send Notification';

  @override
  String get audience => 'Audience';

  @override
  String get allStudents => 'All Students';

  @override
  String get activeOnly => 'Active Only';

  @override
  String get individual => 'Individual';

  @override
  String get selectStudents => 'Select students';

  @override
  String get notificationTitle => 'Notification Title';

  @override
  String get notificationTitleHint => 'e.g. Updated Class Schedule';

  @override
  String get messageBody => 'Message Body';

  @override
  String get messageBodyHint => 'Write your announcement...';

  @override
  String get pinAnnouncement => 'Pin Announcement';

  @override
  String get pinAnnouncementSubtitle => 'Always visible at the top';

  @override
  String get sendNotificationButton => 'Send Notification';

  @override
  String get notificationSentSuccessfully => 'Notification sent successfully';

  @override
  String get totalOfStudents => 'Total of students';

  @override
  String totalNumberOfStudents(int totalNumberOfStudents) {
    return 'Total number of students $totalNumberOfStudents ';
  }

  @override
  String get activeStudents => 'Active Students';

  @override
  String totalNumberOfActiveStudents(int totalNumberOfActiveStudents) {
    return 'Total number of active students $totalNumberOfActiveStudents ';
  }

  @override
  String get revenue => 'Revenue';

  @override
  String totalRevenue(int totalRevenue) {
    return 'Total Revenue $totalRevenue ';
  }

  @override
  String totalNumberOfTodaysClasses(int totalNumberOfTodaysClasses) {
    return 'Total number of today\'s classes $totalNumberOfTodaysClasses ';
  }

  @override
  String get studentGrowth => 'Student Growth';

  @override
  String get last7Weeks => 'Last 7 weeks';

  @override
  String get viewAnalytics => 'View Analytics';

  @override
  String get analytics => 'Analytics';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get year => 'Year';

  @override
  String get totalStudents => 'Total Students';

  @override
  String get avgScore => 'Avg Score';

  @override
  String get active => 'Active';

  @override
  String get weeklyEnrollments => 'Weekly enrollments';

  @override
  String get monthlyRevenue => 'Monthly Revenue';

  @override
  String get last4Months => 'Last 4 months';

  @override
  String get lessonCompletion => 'Lesson Completion';

  @override
  String get attendanceRate => 'Attendance Rate';

  @override
  String get dailyAttendance => 'Daily Attendance';

  @override
  String get examPerformance => 'Exam Performance';

  @override
  String get avg => 'avg';

  @override
  String get january => 'January';

  @override
  String get february => 'February';

  @override
  String get march => 'March';

  @override
  String get april => 'April';

  @override
  String get may => 'May';

  @override
  String get june => 'June';

  @override
  String get july => 'July';

  @override
  String get august => 'August';

  @override
  String get september => 'September';

  @override
  String get october => 'October';

  @override
  String get november => 'November';

  @override
  String get december => 'December';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get addLesson => 'Add Lesson';

  @override
  String get createExam => 'Create Exam';

  @override
  String get notify => 'Notify';

  @override
  String get addNewLesson => 'Add New Lesson';

  @override
  String get lessonTitle => 'Lesson Title';

  @override
  String get lessonTitleHint => 'e.g. Introduction to Calculus';

  @override
  String get duration => 'Duration';

  @override
  String get durationHint => 'e.g. 45 min';

  @override
  String get subject => 'Subject';

  @override
  String get description => 'Description';

  @override
  String get descriptionHint => 'What will students learn in this lesson?';

  @override
  String get premiumContent => 'Premium Content';

  @override
  String get premiumContentSubtitle => 'Only paid subscribers can access';

  @override
  String get nextUploadVideo => 'Next: Upload Video';

  @override
  String get uploadVideo => 'Upload Video';

  @override
  String get uploadVideoSubtitle => 'MP4, MOV · Max 2GB';

  @override
  String get chooseFile => 'Choose File';

  @override
  String get processingTime => 'Processing Time';

  @override
  String get processingTimeSubtitle =>
      'Videos are transcoded for all device qualities. Usually takes 5-20 minutes.';

  @override
  String get nextAddPdfs => 'Next: Add PDFs';

  @override
  String get uploadPdf => 'Upload PDF';

  @override
  String get uploadPdfSubtitle => 'PDF · Max 50MB';

  @override
  String get details => 'Details';

  @override
  String get video => 'Video';

  @override
  String get pdfs => 'PDFs';

  @override
  String get questionBuilder => 'Question Builder';

  @override
  String questionNumber(int number) {
    return 'Question $number';
  }

  @override
  String get enterYourQuestion => 'Enter your question...';

  @override
  String get optionsSelectCorrectAnswer => 'OPTIONS (select correct answer)';

  @override
  String optionHint(String label) {
    return 'Option $label...';
  }

  @override
  String get addQuestion => 'Add Question';

  @override
  String publishExam(int count) {
    return 'Publish Exam ($count Questions)';
  }

  @override
  String get completeAllQuestionsBeforePublishing =>
      'Please complete all questions and select correct answers before publishing';

  @override
  String get examPublishedSuccessfully => 'Exam published successfully';

  @override
  String saveAttendanceCount(int count) {
    return 'Save Attendance ($count students)';
  }

  @override
  String get attendanceSavedSuccessfully => 'Attendance saved successfully';

  @override
  String get publishLesson => 'Publish Lesson';

  @override
  String get students => 'Students';

  @override
  String get searchStudents => 'Search students...';

  @override
  String get block => 'Block';

  @override
  String get all => 'All';

  @override
  String get inactive => 'Inactive';

  @override
  String get blocked => 'Blocked';

  @override
  String get studentDetails => 'Student Details';

  @override
  String get lessonProgress => 'Lesson Progress';

  @override
  String get contactInfo => 'Contact Info';

  @override
  String get phone => 'Phone';

  @override
  String get message => 'Message';

  @override
  String get recentActivities => 'Recent Activities';

  @override
  String get whatsappNotInstalled => 'WhatsApp is not installed on this device';

  @override
  String get published => 'Published';

  @override
  String get draft => 'Draft';

  @override
  String get publish => 'Publish';

  @override
  String get editLesson => 'Edit Lesson';

  @override
  String get changeThumbnail => 'Change Thumbnail';

  @override
  String get changeVideo => 'Change Video';

  @override
  String get changePdfs => 'Change PDFs';

  @override
  String get enterLessonTitle => 'Enter lesson title';

  @override
  String get lessonDescription => 'Lesson Description';

  @override
  String get enterLessonDescription => 'Enter lesson description';

  @override
  String get reviewHomework => 'Review Homework';

  @override
  String get download => 'Download';

  @override
  String get pdfPreview => 'PDF Preview';

  @override
  String get gradeOutOf100 => 'GRADE (out of 100)';

  @override
  String get feedback => 'FEEDBACK';

  @override
  String get feedbackHint => 'Add feedback for the student...';

  @override
  String get submitGrade => 'Submit Grade';

  @override
  String get enterAValidGrade => 'Please enter a valid grade';

  @override
  String get publishedSubtitle => 'This lesson is visible to students';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get deleteLesson => 'Delete Lesson';

  @override
  String get pendingReview => 'Pending Review';

  @override
  String get submissions => 'Submissions';

  @override
  String get tapToReviewAndGrade => 'Tap to Review & Grade';

  @override
  String gradeValue(int grade) {
    return 'Grade: $grade/100';
  }

  @override
  String daysAgo(int count) {
    return '$count days ago';
  }

  @override
  String hoursAgo(int count) {
    return '$count hours ago';
  }

  @override
  String minutesAgo(int count) {
    return '$count minutes ago';
  }

  @override
  String get justNow => 'Just now';

  @override
  String get noSubmissionsYet => 'No submissions yet';

  @override
  String get gradeCannotExceed100 => 'Grade cannot exceed 100';

  @override
  String get gradeSubmittedSuccessfully => 'Grade submitted successfully';

  @override
  String get views => 'Views';

  @override
  String get edit => 'Edit';

  @override
  String get chats => 'Chats';

  @override
  String get searchChats => 'Search chats...';

  @override
  String get noConversationsYet => 'No conversations yet';

  @override
  String get rating => 'Rating';

  @override
  String get years => 'Years';

  @override
  String get accountPreferences => 'Account Preferences';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get subjectRequired => 'Please enter your subject';

  @override
  String get yearsOfExperience => 'Years of Experience';

  @override
  String get enterFullName => 'Enter your full name';

  @override
  String get enterSubject => 'Enter your subject';

  @override
  String get enterYearsOfExperience => 'Enter your years of experience';

  @override
  String get mySubjectsAndClasses => 'My Subjects & Classes';

  @override
  String get studentMessageAlerts => 'Student Message Alerts';

  @override
  String get payments => 'Payments';

  @override
  String get earningsAndPayouts => 'Earnings & Payouts';

  @override
  String get paymentMethods => 'Payment Methods';

  @override
  String classSummary(int classes, int students) {
    return '$classes classes · $students students';
  }

  @override
  String get addSubject => 'Add Subject';

  @override
  String get editSubject => 'Edit Subject';

  @override
  String get subjectNameHint => 'e.g. Mathematics';

  @override
  String get noSubjectsYet => 'No subjects added yet';

  @override
  String get studentsAndRatingAreComputed =>
      'Students count and rating are calculated automatically and can\'t be edited here.';

  @override
  String get delete => 'Delete';

  @override
  String get noPublishedLessons => 'No published lessons';

  @override
  String get noDraftLessons => 'No draft lessons';

  @override
  String get alertParent => 'Alert Parent';

  @override
  String get thisMonth => 'This Month';

  @override
  String examAvgAndPassRate(String avg, String passRate) {
    return 'Avg: $avg% · Pass rate: $passRate%';
  }

  @override
  String get saveAsDraft => 'Save as Draft';

  @override
  String get lessonPublishedSuccessfully => 'Lesson published successfully';

  @override
  String get lessonSavedAsDraft => 'Lesson saved as draft';

  @override
  String passRate(String rate) {
    return 'Pass rate: $rate%';
  }

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
