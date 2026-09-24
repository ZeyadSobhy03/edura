import 'package:edura/edura_app.dart';

import 'package:edura/presentation/auth/login/presentation/view_model/login_view_model.dart';
import 'package:edura/presentation/auth/register/presentation/view_model/register_view_model.dart';

import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view_model/exam/exam_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view_model/teacher_notification/teacher_notification_view_model.dart';

import 'package:edura/presentation/role/teacher/tabs/students/presentation/view_model/student/student_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/students/presentation/view_model/teacher/teacher_view_model.dart';

import 'package:edura/presentation/role/teacher/tabs/teacher_chats/presentation/view_model/chats_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view_model/home_work/home_work_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view_model/lessons/teacher_lessons_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/presentation/view_model/grade_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/payment/presentation/view_model/payment_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/presentation/view_model/subject_classes_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view_model/teacher_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/DI/injection.dart';

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
  configureDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
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
      ],

      child: const EduraApp(),
    ),
  );
}
