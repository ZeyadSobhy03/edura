// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../presentation/auth/login/data/data_source/remote/login_remote_data_source.dart'
    as _i1025;
import '../../presentation/auth/login/data/data_source/remote/login_supabase_data_source.dart'
    as _i722;
import '../../presentation/auth/login/data/repositories/login_repositories.dart'
    as _i43;
import '../../presentation/auth/login/data/repositories/login_repositories_imp.dart'
    as _i75;
import '../../presentation/auth/login/domain/use_case/login_use_case.dart'
    as _i999;
import '../../presentation/auth/login/presentation/view_model/login_view_model.dart'
    as _i1058;
import '../../presentation/auth/register/data/data_source/register_remote_data_source.dart'
    as _i873;
import '../../presentation/auth/register/data/data_source/register_supabase_data_source.dart'
    as _i937;
import '../../presentation/auth/register/data/repositories/register_repositories.dart'
    as _i372;
import '../../presentation/auth/register/data/repositories/register_repositories_imp.dart'
    as _i985;
import '../../presentation/auth/register/domain/use_case/register_use_case.dart'
    as _i266;
import '../../presentation/auth/register/presentation/view_model/register_view_model.dart'
    as _i23;
import '../../presentation/role/teacher/tabs/dashboard/data/data_source/exam_remote_data_source.dart'
    as _i1048;
import '../../presentation/role/teacher/tabs/dashboard/data/data_source/exam_supabase_data_source.dart'
    as _i400;
import '../../presentation/role/teacher/tabs/dashboard/data/repositories/exam_repositories.dart'
    as _i386;
import '../../presentation/role/teacher/tabs/dashboard/data/repositories/exam_repositories_imp.dart'
    as _i790;
import '../../presentation/role/teacher/tabs/dashboard/domain/use_case/exam_use_case.dart'
    as _i84;
import '../../presentation/role/teacher/tabs/dashboard/presentation/view_model/exam_view_model.dart'
    as _i228;
import '../../presentation/role/teacher/tabs/students/data/data_source/student/student_remote_data_source.dart'
    as _i129;
import '../../presentation/role/teacher/tabs/students/data/data_source/student/student_supabase_data_source.dart'
    as _i228;
import '../../presentation/role/teacher/tabs/students/data/data_source/teacher/teacher_remote_data_source.dart'
    as _i617;
import '../../presentation/role/teacher/tabs/students/data/data_source/teacher/teacher_supabase_data_source.dart'
    as _i156;
import '../../presentation/role/teacher/tabs/students/data/repositories/student/student_repositories.dart'
    as _i74;
import '../../presentation/role/teacher/tabs/students/data/repositories/student/student_repositories_imp.dart'
    as _i593;
import '../../presentation/role/teacher/tabs/students/data/repositories/teacher/teacher_repositories.dart'
    as _i200;
import '../../presentation/role/teacher/tabs/students/data/repositories/teacher/teacher_repositories_imp.dart'
    as _i466;
import '../../presentation/role/teacher/tabs/students/domain/use_case/student/student_use_case.dart'
    as _i406;
import '../../presentation/role/teacher/tabs/students/domain/use_case/teacher/teacher_use_case.dart'
    as _i93;
import '../../presentation/role/teacher/tabs/students/presentation/view_model/student/student_view_model.dart'
    as _i342;
import '../../presentation/role/teacher/tabs/students/presentation/view_model/teacher/teacher_view_model.dart'
    as _i623;
import '../../presentation/role/teacher/tabs/teacher_chats/data/data_source/chats_remote_data_source.dart'
    as _i53;
import '../../presentation/role/teacher/tabs/teacher_chats/data/data_source/chats_supabase_data_source.dart'
    as _i480;
import '../../presentation/role/teacher/tabs/teacher_chats/data/repositories/chats_repositories.dart'
    as _i594;
import '../../presentation/role/teacher/tabs/teacher_chats/data/repositories/chats_repositories_imp.dart'
    as _i696;
import '../../presentation/role/teacher/tabs/teacher_chats/domain/use_case/chats_use_case.dart'
    as _i828;
import '../../presentation/role/teacher/tabs/teacher_chats/presentation/view_model/chats_view_model.dart'
    as _i964;
import '../../presentation/role/teacher/tabs/teacher_lessons/data/data_source/home_work/home_work_remote_data_source.dart'
    as _i1009;
import '../../presentation/role/teacher/tabs/teacher_lessons/data/data_source/home_work/home_work_supabase_data_source.dart'
    as _i480;
import '../../presentation/role/teacher/tabs/teacher_lessons/data/data_source/lessons/teacher_lessons_remote_data_source.dart'
    as _i619;
import '../../presentation/role/teacher/tabs/teacher_lessons/data/data_source/lessons/teacher_lessons_supabase_data_source.dart'
    as _i815;
import '../../presentation/role/teacher/tabs/teacher_lessons/data/repositories/home_work/home_work_repositories.dart'
    as _i819;
import '../../presentation/role/teacher/tabs/teacher_lessons/data/repositories/home_work/home_work_repositories_imp.dart'
    as _i614;
import '../../presentation/role/teacher/tabs/teacher_lessons/data/repositories/lessons/teacher_lessons_repositories.dart'
    as _i775;
import '../../presentation/role/teacher/tabs/teacher_lessons/data/repositories/lessons/teacher_lessons_repositories_imp.dart'
    as _i99;
import '../../presentation/role/teacher/tabs/teacher_lessons/domain/use_case/home_work/home_work_use_case.dart'
    as _i197;
import '../../presentation/role/teacher/tabs/teacher_lessons/domain/use_case/lessons/teacher_lessons_use_case.dart'
    as _i213;
import '../../presentation/role/teacher/tabs/teacher_lessons/presentation/view_model/home_work/home_work_view_model.dart'
    as _i847;
import '../../presentation/role/teacher/tabs/teacher_lessons/presentation/view_model/lessons/teacher_lessons_view_model.dart'
    as _i551;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i1048.ExamRemoteDataSource>(
      () => _i400.ExamSupabaseDataSource(),
    );
    gh.lazySingleton<_i1025.LoginRemoteDataSource>(
      () => _i722.LoginSupabaseDataSource(),
    );
    gh.lazySingleton<_i1009.HomeWorkRemoteDataSource>(
      () => _i480.HomeWorkSupabaseDataSource(),
    );
    gh.lazySingleton<_i619.TeacherLessonsRemoteDataSource>(
      () => _i815.TeacherLessonsSupabaseDataSource(),
    );
    gh.lazySingleton<_i53.ChatsRemoteDataSource>(
      () => _i480.ChatsSupabaseDataSource(),
    );
    gh.lazySingleton<_i129.StudentRemoteDataSource>(
      () => _i228.StudentSupabaseDataSource(),
    );
    gh.lazySingleton<_i775.TeacherLessonsRepositories>(
      () => _i99.TeacherLessonsRepositoriesImp(
        remoteDataSource: gh<_i619.TeacherLessonsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i873.RegisterRemoteDataSource>(
      () => _i937.RegisterSupabaseDataSource(),
    );
    gh.lazySingleton<_i819.HomeWorkRepositories>(
      () => _i614.HomeWorkRepositoriesImp(
        remoteDataSource: gh<_i1009.HomeWorkRemoteDataSource>(),
      ),
    );
    gh.factory<_i197.HomeWorkUseCase>(
      () => _i197.HomeWorkUseCase(
        homeWorkRepositories: gh<_i819.HomeWorkRepositories>(),
      ),
    );
    gh.lazySingleton<_i617.TeacherRemoteDataSource>(
      () => _i156.TeacherSupabaseDataSource(),
    );
    gh.lazySingleton<_i200.TeacherRepositories>(
      () => _i466.TeacherRepositoriesImp(
        remoteDataSource: gh<_i617.TeacherRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i386.ExamRepositories>(
      () => _i790.ExamRepositoriesImp(
        remoteDataSource: gh<_i1048.ExamRemoteDataSource>(),
      ),
    );
    gh.factory<_i213.TeacherLessonsUseCase>(
      () => _i213.TeacherLessonsUseCase(
        repositories: gh<_i775.TeacherLessonsRepositories>(),
      ),
    );
    gh.lazySingleton<_i43.LoginRepositories>(
      () => _i75.LoginRepositoriesImp(
        remoteDataSource: gh<_i1025.LoginRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i372.RegisterRepositories>(
      () => _i985.RegisterRepositoriesImp(
        remoteDataSource: gh<_i873.RegisterRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i74.StudentRepositories>(
      () => _i593.StudentRepositoriesImp(
        remoteDataSource: gh<_i129.StudentRemoteDataSource>(),
      ),
    );
    gh.factory<_i93.TeacherUseCase>(
      () => _i93.TeacherUseCase(repositories: gh<_i200.TeacherRepositories>()),
    );
    gh.factory<_i847.HomeWorkCubit>(
      () => _i847.HomeWorkCubit(useCase: gh<_i197.HomeWorkUseCase>()),
    );
    gh.lazySingleton<_i594.ChatsRepositories>(
      () => _i696.ChatsRepositoriesImp(
        remoteDataSource: gh<_i53.ChatsRemoteDataSource>(),
      ),
    );
    gh.factory<_i999.LoginUseCase>(
      () => _i999.LoginUseCase(loginRepositories: gh<_i43.LoginRepositories>()),
    );
    gh.factory<_i266.RegisterUseCase>(
      () =>
          _i266.RegisterUseCase(repositories: gh<_i372.RegisterRepositories>()),
    );
    gh.factory<_i84.ExamUseCase>(
      () => _i84.ExamUseCase(repositories: gh<_i386.ExamRepositories>()),
    );
    gh.factory<_i23.RegisterCubit>(
      () => _i23.RegisterCubit(registerUseCase: gh<_i266.RegisterUseCase>()),
    );
    gh.factory<_i623.TeacherCubit>(
      () => _i623.TeacherCubit(teacherUseCase: gh<_i93.TeacherUseCase>()),
    );
    gh.factory<_i828.ChatsUseCase>(
      () => _i828.ChatsUseCase(repositories: gh<_i594.ChatsRepositories>()),
    );
    gh.factory<_i1058.LoginCubit>(
      () => _i1058.LoginCubit(loginUseCase: gh<_i999.LoginUseCase>()),
    );
    gh.factory<_i551.TeacherLessonsCubit>(
      () => _i551.TeacherLessonsCubit(
        teacherLessonsUseCase: gh<_i213.TeacherLessonsUseCase>(),
      ),
    );
    gh.factory<_i964.ChatsCubit>(
      () => _i964.ChatsCubit(chatsUseCase: gh<_i828.ChatsUseCase>()),
    );
    gh.factory<_i964.MessagesCubit>(
      () => _i964.MessagesCubit(chatsUseCase: gh<_i828.ChatsUseCase>()),
    );
    gh.factory<_i406.StudentUseCase>(
      () => _i406.StudentUseCase(repositories: gh<_i74.StudentRepositories>()),
    );
    gh.factory<_i342.StudentCubit>(
      () => _i342.StudentCubit(studentUseCase: gh<_i406.StudentUseCase>()),
    );
    gh.factory<_i228.ExamCubit>(
      () => _i228.ExamCubit(examUseCase: gh<_i84.ExamUseCase>()),
    );
    return this;
  }
}
