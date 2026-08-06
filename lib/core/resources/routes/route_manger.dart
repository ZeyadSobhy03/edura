import 'package:edura/core/model/exam_attempt_arguments.dart';
import 'package:edura/presentation/role/student/student_main_layout.dart';
import 'package:edura/presentation/role/student/tabs/exams/exam_details/exam_details.dart';
import 'package:edura/presentation/role/student/tabs/exams/exam_details/section/exam_attempt_screen.dart';
import 'package:edura/presentation/role/student/tabs/home/section/announcements/announcements_screen.dart';
import 'package:edura/presentation/role/student/tabs/home/section/notification/student_notification_screen.dart';
import 'package:edura/presentation/role/student/tabs/lessons/lessons.dart';
import 'package:edura/presentation/role/student/tabs/lessons/section/homework_screen.dart';
import 'package:edura/presentation/role/student/tabs/lessons/section/lesson_details.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/achievements/achievements_screen.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/leaderboard/leaderboard_screen.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/schedule/schedule_screen.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/settings/sections/change_password_screen.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/settings/sections/edit_profile_screen.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/settings/sections/contact_support_screen.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/settings/sections/help_faq_screen.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/settings/settings_screen.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/settings/sections/webview_screen.dart';
import 'package:flutter/material.dart';

import '../../../presentation/auth/forget_password/forget_password.dart';
import '../../../presentation/auth/login/login.dart';
import '../../../presentation/auth/register/register.dart';
import '../../../presentation/role/student/tabs/profile/section/attendance/attendance_screen.dart';
import '../../../presentation/role/student/tabs/profile/section/notes/notes_screen.dart';
import '../../../presentation/splash_screen/splash_screen.dart';
import '../../model/edit_profile_arguments.dart';
import '../../model/homework_model.dart';
import '../../model/lesson_model.dart';
import '../../model/web_view_arguments.dart';

class RouteManger {
  static const String initialRoute = '/';
  static const String eduraAppRoute = '/eduraApp';
  static const String registerRoute = '/register';
  static const String forgetPasswordRoute = '/forgetPassword';
  static const String loginRoute = '/login';
  static const String splashRoute = '/splashScreen';
  static const String studentMainLayoutRoute = '/studentMainLayout';
  static const String studentNotificationScreen = '/studentNotificationScreen';
  static const String lessonDetails = '/lessonDetails';
  static const String homeWorkScreen = '/homeWorkScreen';
  static const String lessonsScreen = '/lessonsScreen';
  static const String announcementsScreen = '/announcementsScreen';
  static const String examDetailsScreen = '/examDetailsScreen';
  static const String examAttemptScreen = '/examAttemptScreen';
  static const String leaderboardScreen = "/leaderboardScreen";
  static const String scheduleScreen = "/scheduleScreen";
  static const String achievementScreen = "/achievementScreen";
  static const String notesScreen = '/notesScreen';
  static const String attendanceScreen = '/attendanceScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String webViewScreen = '/webViewScreen';
  static const String getSupportScreen = '/getSupportScreen';
  static const String helpAndFaqScreen = '/helpAndFaqScreen';
  static const String settingsScreen = '/settingsScreen';

  static Route router(RouteSettings settings) {
    switch (settings.name) {
      case registerRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const Register();
          },
        );

      case forgetPasswordRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const ForgetPassword();
          },
        );

      case homeWorkScreen:
        final homework = settings.arguments as List<HomeworkModel>?;
        return MaterialPageRoute(
          builder: (context) => HomeworkScreen(homeworkList: homework),
        );

      case loginRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const Login();
          },
        );

      case splashRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );
      case notesScreen:
        return MaterialPageRoute(builder: (context) => const NotesScreen());
      case studentMainLayoutRoute:
        final initialIndex = settings.arguments as int? ?? 0;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => StudentMainLayout(initialIndex: initialIndex),
        );

      case studentNotificationScreen:
        return MaterialPageRoute(
          builder: (context) => const StudentNotificationScreen(),
        );

      case lessonDetails:
        final lesson = settings.arguments as LessonModel;
        return MaterialPageRoute(
          builder: (context) => LessonDetails(lesson: lesson),
        );

      case lessonsScreen:
        return MaterialPageRoute(builder: (context) => Lessons());

      case examAttemptScreen:
        final args = settings.arguments as ExamAttemptArguments;
        return MaterialPageRoute(
          builder: (context) =>
              ExamAttemptScreen(exam: args.exam, questions: args.questions),
        );

      case announcementsScreen:
        return MaterialPageRoute(builder: (context) => AnnouncementsScreen());

      case examDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => ExamDetails(),
          settings: settings,
        );

      case scheduleScreen:
        return MaterialPageRoute(builder: (context) => ScheduleScreen());

      case leaderboardScreen:
        return MaterialPageRoute(builder: (context) => LeaderboardScreen());

      case achievementScreen:
        return MaterialPageRoute(builder: (context) => AchievementsScreen());
      case attendanceScreen:
        return MaterialPageRoute(
          builder: (context) => const AttendanceScreen(),
        );

      case changePasswordScreen:
        return MaterialPageRoute(builder: (context) => ChangePasswordScreen());
      case editProfileScreen:
        final args = settings.arguments as EditProfileArguments;
        final currentName = args.currentName;
        final currentEmail = args.currentEmail;
        return MaterialPageRoute(
          builder: (context) => EditProfileScreen(
            currentName: currentName,
            currentEmail: currentEmail,
          ),
        );

      case webViewScreen:
        final args = settings.arguments as WebViewArguments;
        final title = args.title;
        final url = args.url;
        return MaterialPageRoute(
          builder: (context) => WebViewScreen(title: title, url: url),
        );

      case helpAndFaqScreen:
        return MaterialPageRoute(builder: (context) => HelpFaqScreen());

      case getSupportScreen:
        return MaterialPageRoute(builder: (context) => ContactSupportScreen());

      case settingsScreen:
        return MaterialPageRoute(builder: (context) => SettingsScreen());
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(body: Center(child: Text('No Route Found')));
          },
        );
    }
  }
}
