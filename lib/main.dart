import 'package:edura/edura_app.dart';
import 'package:edura/presentation/auth/login/data/data_source/remote/login_supabase_data_source.dart';
import 'package:edura/presentation/auth/login/data/repositories/login_repositories_imp.dart';
import 'package:edura/presentation/auth/login/domain/use_case/login_use_case.dart';
import 'package:edura/presentation/auth/login/presentation/view_model/login_view_model.dart';
import 'package:edura/presentation/auth/register/data/data_source/register_supabase_data_source.dart';
import 'package:edura/presentation/auth/register/data/repositories/register_repositories_imp.dart';
import 'package:edura/presentation/auth/register/domain/use_case/register_use_case.dart';
import 'package:edura/presentation/auth/register/presentation/view_model/register_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/data_source/exam_supabase_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/repositories/exam_repositories_imp.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/domain/use_case/exam_use_case.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view_model/exam_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/data_source/teacher_lessons_supabase_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/repositories/teacher_lessons_repositories_imp.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/domain/use_case/teacher_lessons_use_case.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view_model/teacher_lessons_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const webClientId =
      '253234772403-pn4ubo3k6lkg9tkmaoolps40ruv8fjh4.apps.googleusercontent.com';
  final googleSignIn = GoogleSignIn.instance;
  await Supabase.initialize(
    url: 'https://daxgkzzwfnpyqsjcpnad.supabase.co',
    publishableKey: 'sb_publishable_nY126vB7GG51e9EW2SOxew_A8wycwJY',
  );
  await googleSignIn.initialize(
    serverClientId:
        "253234772403-pn4ubo3k6lkg9tkmaoolps40ruv8fjh4.apps.googleusercontent.com",
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(
            loginUseCase: LoginUseCase(
              loginRepositories: LoginRepositoriesImp(
                remoteDataSource: LoginSupabaseDataSource(),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => TeacherLessonsCubit(
            teacherLessonsUseCase: TeacherLessonsUseCase(
              repositories: TeacherLessonsRepositoriesImp(
                remoteDataSource: TeacherLessonsSupabaseDataSource(),
              ),
            ),
          ),
        ),

        BlocProvider(
          create: (context) => ExamCubit(
            examUseCase: ExamUseCase(
              repositories: ExamRepositoriesImp(
                remoteDataSource: ExamSupabaseDataSource(),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(
            registerUseCase: RegisterUseCase(
              repositories: RegisterRepositoriesImp(
                remoteDataSource: RegisterSupabaseDataSource(),
              ),
            ),
          ),
        ),
      ],

      child: const EduraApp(),
    ),
  );
}
