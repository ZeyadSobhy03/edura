import 'package:edura/edura_app.dart';
import 'package:edura/presentation/auth/log_out/presentation/view_model/log_out_view_model.dart';

import 'package:edura/presentation/auth/login/presentation/view_model/login_view_model.dart';
import 'package:edura/presentation/auth/register/presentation/view_model/register_view_model.dart';
import 'package:edura/presentation/role/student/tabs/exams/presentation/view_model/exam_view_model.dart';
import 'package:edura/presentation/role/student/tabs/home/presentation/view_model/student_notification/student_notification_view_model.dart';
import 'package:edura/presentation/role/student/tabs/home/presentation/view_model/student_stats/student_stats_view_model.dart';
import 'package:edura/presentation/role/student/tabs/lessons/presentation/view_model/lesson_progress/lesson_progress_view_model.dart';
import 'package:edura/presentation/role/student/tabs/lessons/presentation/view_model/student_home_work/student_home_work_view_model.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view_model/achievements/achievements_view_model.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view_model/attendance/attendance_view_model.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view_model/leaderboard/leaderboard_view_model.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view_model/schedule/schedule_view_model.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view_model/student_notes/student_notes_view_model.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view_model/student_profile/student_profile_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view_model/activities/activities_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view_model/analytics/analytics_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view_model/dashboard/dashboard_view_model.dart';

import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view_model/exam/exam_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view_model/teacher_notification/teacher_notification_view_model.dart';

import 'package:edura/presentation/role/teacher/tabs/students/presentation/view_model/student/student_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/students/presentation/view_model/teacher/teacher_view_model.dart';

import 'package:edura/presentation/role/teacher/tabs/teacher_chats/presentation/view_model/chats_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view_model/home_work/home_work_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view_model/lessons/teacher_lessons_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/presentation/view_model/class_schedules_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/presentation/view_model/grade_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/payment/presentation/view_model/payment_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/presentation/view_model/subject_classes_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view_model/change_password/change_password_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view_model/teacher_profile/teacher_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/DI/injection.dart';
import 'presentation/auth/login/data/data_source/local/login_hive_data_source.dart';
import 'core/cubit/language_cubit.dart';

Future<void> _initializeHive() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox<dynamic>(LoginHiveDataSource.boxName);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  // const supabasePublishableKey =
  // String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');
  //
  // const googleServerClientId =
  // String.fromEnvironment('GOOGLE_SERVER_CLIENT_ID');

  final googleSignIn = GoogleSignIn.instance;
  await Supabase.initialize(
    url: 'https://daxgkzzwfnpyqsjcpnad.supabase.co',
    publishableKey: 'sb_publishable_nY126vB7GG51e9EW2SOxew_A8wycwJY',
  );
  await googleSignIn.initialize(
    serverClientId:
        "253234772403-pn4ubo3k6lkg9tkmaoolps40ruv8fjh4.apps.googleusercontent.com",
  );
  await _initializeHive();
  configureDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguageCubit()),
        BlocProvider(create: (context) => getIt<LoginCubit>()),
        BlocProvider(create: (context) => getIt<TeacherLessonsCubit>()),
        BlocProvider(create: (context) => getIt<ExamCubit>()),
        BlocProvider(create: (context) => getIt<RegisterCubit>()),
        BlocProvider(create: (context) => getIt<StudentCubit>()),
        BlocProvider(create: (context) => getIt<ChatsCubit>()),
        BlocProvider(create: (context) => getIt<MessagesCubit>()),
        BlocProvider(create: (context) => getIt<TeacherCubit>()),
        BlocProvider(create: (context) => getIt<HomeWorkCubit>()),
        BlocProvider(create: (context) => getIt<TeacherNotificationCubit>()),
        BlocProvider(create: (context) => getIt<TeacherProfileCubit>()),
        BlocProvider(create: (context) => getIt<GardeCubit>()),
        BlocProvider(create: (context) => getIt<SubjectClassesCubit>()),
        BlocProvider(create: (context) => getIt<PaymentCubit>()),
        BlocProvider(create: (context) => getIt<ScheduleCubit>()),
        BlocProvider(create: (context) => getIt<DashboardCubit>()),
        BlocProvider(create: (context) => getIt<ActivitiesCubit>()),
        BlocProvider(create: (context) => getIt<LessonProgressCubit>()),
        BlocProvider(create: (context) => getIt<StudentNotesCubit>()),
        BlocProvider(create: (context) => getIt<StudentHomeWorkCubit>()),
        BlocProvider(create: (context) => getIt<ChangePasswordCubit>()),
        BlocProvider(create: (context) => getIt<AnalyticsCubit>()),
        BlocProvider(create: (context) => getIt<LogOutCubit>(),),
        BlocProvider(create: (context) => getIt<LeaderboardCubit>(),),
        BlocProvider(create: (context) => getIt<StudentNotificationCubit>(),),
        BlocProvider(create: (context) => getIt<StudentScheduleCubit>(),),
        BlocProvider(create: (context) => getIt<AchievementsCubit>(),),
        BlocProvider(create: (context) => getIt<AttendanceCubit>(),),
        BlocProvider(create: (context) => getIt<StudentStatsCubit>()),
        BlocProvider(create: (context) => getIt<StudentProfileCubit>(),),
        BlocProvider(create: (context) => getIt<StudentExamCubit>(),),
      ],

      child: const EduraApp(),
    ),
  );
}
