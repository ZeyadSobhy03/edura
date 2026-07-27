import 'package:edura/presentation/role/student/student_main_layout.dart';
import 'package:edura/presentation/role/student/tabs/home/section/announcements/announcements_screen.dart';
import 'package:edura/presentation/role/student/tabs/home/section/notification/student_notification_screen.dart';
import 'package:edura/presentation/role/student/tabs/lessons/lessons.dart';
import 'package:edura/presentation/role/student/tabs/lessons/section/homework_screen.dart';
import 'package:edura/presentation/role/student/tabs/lessons/section/lesson_details.dart';
import 'package:flutter/material.dart';

import '../../../presentation/auth/forget_password/forget_password.dart';
import '../../../presentation/auth/login/login.dart';
import '../../../presentation/auth/register/register.dart';
import '../../../presentation/splash_screen/splash_screen.dart';
import '../../model/homework_model.dart';
import '../../model/lesson_model.dart';

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

      case announcementsScreen:
        return MaterialPageRoute(builder: (context) => AnnouncementsScreen());

      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(body: Center(child: Text('No Route Found')));
          },
        );
    }
  }
}
