import 'package:edura/core/model/chat_args.dart';
import 'package:edura/core/model/exam_attempt_arguments.dart';
import 'package:edura/core/model/homework_submission_model.dart';
import 'package:edura/core/model/student_detail_model.dart';
import 'package:edura/core/widgets/chat/chat.dart';
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
import 'package:edura/presentation/role/teacher/tabs/dashboard/section/teacher_notification.dart';
import 'package:edura/presentation/role/teacher/tabs/students/section/student_details.dart';
import 'package:edura/presentation/role/teacher/tabs/students/students.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_chats/teacher_chats.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/section/teacher_homework_screen.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/teacher_lessons.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/teacher_edit_profile/teacher_edit_profile_screen.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/teacher_profile.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/teacher_setting/teacher_setting_screen.dart';
import 'package:flutter/material.dart';

import '../../../presentation/auth/forget_password/forget_password.dart';
import '../../../presentation/auth/login/login.dart';
import '../../../presentation/auth/register/register.dart';
import '../../../presentation/role/student/tabs/chat/student_chats_screen.dart';
import '../../../presentation/role/student/tabs/profile/section/attendance/attendance_screen.dart';
import '../../../presentation/role/student/tabs/profile/section/notes/notes_screen.dart';
import '../../../presentation/role/teacher/tabs/dashboard/section/analytics_screen.dart';
import '../../../presentation/role/teacher/tabs/dashboard/section/attendance/take_attendance_screen.dart';
import '../../../presentation/role/teacher/tabs/dashboard/section/exams/question_builder_screen.dart';
import '../../../presentation/role/teacher/tabs/teacher_lessons/section/add_new_lesson_screen.dart';
import '../../../presentation/role/teacher/tabs/teacher_lessons/section/edit_lesson_screen.dart';
import '../../../presentation/role/teacher/tabs/teacher_lessons/section/review_homework_screen.dart';
import '../../../presentation/role/teacher/tabs/teacher_profile/teacher_setting/section/subjects_classes_screen.dart';
import '../../../presentation/role/teacher/teacher_main_layout.dart';
import '../../../presentation/splash_screen/splash_screen.dart';
import '../../model/edit_profile_arguments.dart';
import '../../model/homework_model.dart';
import '../../model/lesson_model.dart';
import '../../model/teacher_profile_model.dart';
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
  static const String teacherMainLayoutRoute = '/teacherMainLayout';
  static const String teacherNotificationScreen = '/teacherNotificationScreen';
  static const String teacherStudentsScreen = '/teacherStudentsScreen';
  static const String teacherLessonsScreen = '/teacherLessonsScreen';
  static const String teacherChatsScreen = '/teacherChatsScreen';
  static const String takeAttendanceScreen = '/takeAttendanceScreen';

  static const String teacherProfileScreen = '/teacherProfileScreen';
  static const String analyticsScreen = '/analyticsScreen';
  static const String addNewLessonScreen = '/addNewLessonScreen';
  static const String questionBuilderScreen = '/questionBuilderScreen';
  static const String studentDetailsScreen = '/studentDetailsScreen';
  static const String editLessonScreen = '/editLessonScreen';
  static const String reviewHomeworkScreen = '/reviewHomeworkScreen';
  static const String teacherHomeworkScreen = '/teacherHomeworkScreen';
  static const String studentChatsScreen = '/studentChatsScreen';
  static const String chat = '/chat';
  static const String teacherEditProfileScreen = '/teacherEditProfileScreen';
  static const String teacherSettingsScreen = '/teacherSettingsScreen';
  static const String teacherProfileEditScreen = '/teacherProfileEditScreen';

  static const String subjectsClassesScreen= '/subjectsClassesScreen';
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

      case studentDetailsScreen:
        final student = settings.arguments as StudentDetailsModel;
        return MaterialPageRoute(
          builder: (context) => StudentDetails(student: student),
        );

      case chat:
        return MaterialPageRoute(
          builder: (context) {
            final chat = settings.arguments as ChatArgs;
            return Chat(chat: chat);
          },
        );
      case subjectsClassesScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const SubjectsClassesScreen();
          },
        );
      case teacherEditProfileScreen:
        return MaterialPageRoute(
          builder: (context) {
            final teacher = settings.arguments as TeacherProfileModel;
            return TeacherEditProfileScreen(teacher: teacher);
          },
        );

      case teacherMainLayoutRoute:
        final initialIndex = settings.arguments as int? ?? 0;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => TeacherMainLayout(initialIndex: initialIndex),
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

      case studentChatsScreen:
        return MaterialPageRoute(
          builder: (context) => const StudentChatsScreen(),
        );

      case lessonsScreen:
        return MaterialPageRoute(builder: (context) => Lessons());

      case examAttemptScreen:
        final args = settings.arguments as ExamAttemptArguments;
        return MaterialPageRoute(
          builder: (context) =>
              ExamAttemptScreen(exam: args.exam, questions: args.questions),
        );

      case questionBuilderScreen:
        return MaterialPageRoute(
          builder: (context) => const QuestionBuilderScreen(),
        );
      case teacherHomeworkScreen:
        final submissions = settings.arguments as List<HomeworkSubmissionModel>;
        return MaterialPageRoute(
          builder: (context) => TeacherHomeworkScreen(submissions: submissions),
        );
      case announcementsScreen:
        return MaterialPageRoute(builder: (context) => AnnouncementsScreen());
      case addNewLessonScreen:
        return MaterialPageRoute(
          builder: (context) => const AddNewLessonScreen(),
        );
      case examDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => ExamDetails(),
          settings: settings,
        );
      case takeAttendanceScreen:
        return MaterialPageRoute(
          builder: (context) => const TakeAttendanceScreen(),
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

      case teacherSettingsScreen:
        final teacher = settings.arguments as TeacherProfileModel;
        return MaterialPageRoute(
          builder: (context) {
            return TeacherSettingScreen(teacher: teacher);
          },
        );

      case teacherProfileEditScreen:
        return MaterialPageRoute(
          builder: (context) {
            final teacher = settings.arguments as TeacherProfileModel;
            return TeacherEditProfileScreen(teacher: teacher);
          },
        );

      case analyticsScreen:
        return MaterialPageRoute(builder: (context) => const AnalyticsScreen());

      case teacherChatsScreen:
        return MaterialPageRoute(builder: (context) => TeacherChats());

      case teacherLessonsScreen:
        return MaterialPageRoute(builder: (context) => TeacherLessons());

      case editLessonScreen:
        final lesson = settings.arguments as LessonModel;
        return MaterialPageRoute(
          builder: (context) => EditLessonScreen(lesson: lesson),
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

      case teacherNotificationScreen:
        return MaterialPageRoute(builder: (context) => TeacherNotification());

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

      case teacherStudentsScreen:
        return MaterialPageRoute(builder: (context) => Students());

      case reviewHomeworkScreen:
        final submission = settings.arguments as HomeworkSubmissionModel;
        return MaterialPageRoute(
          builder: (context) => ReviewHomeworkScreen(submission: submission),
        );

      case settingsScreen:
        return MaterialPageRoute(builder: (context) => SettingsScreen());

      case teacherProfileScreen:
        return MaterialPageRoute(builder: (context) => TeacherProfile());
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(body: Center(child: Text('No Route Found')));
          },
        );
    }
  }
}
