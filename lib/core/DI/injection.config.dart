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
import '../../presentation/role/student/tabs/home/data/data_source/student_notification/student_notification_remote_data_source.dart'
    as _i311;
import '../../presentation/role/student/tabs/home/data/data_source/student_notification/student_notification_supabase_data_source.dart'
    as _i337;
import '../../presentation/role/student/tabs/home/data/data_source/student_stats/student_stats_remote_data_source.dart'
    as _i556;
import '../../presentation/role/student/tabs/home/data/data_source/student_stats/student_stats_supabase_data_source.dart'
    as _i1072;
import '../../presentation/role/student/tabs/home/data/repositories/student_notification/student_notification_repositories.dart'
    as _i157;
import '../../presentation/role/student/tabs/home/data/repositories/student_notification/student_notification_repositories_imp.dart'
    as _i249;
import '../../presentation/role/student/tabs/home/data/repositories/student_stats/student_stats_repositories.dart'
    as _i869;
import '../../presentation/role/student/tabs/home/data/repositories/student_stats/student_stats_repositories_imp.dart'
    as _i864;
import '../../presentation/role/student/tabs/home/domain/use_case/student_notification/student_notification_use_case.dart'
    as _i85;
import '../../presentation/role/student/tabs/home/domain/use_case/student_stats/student_stats_use_case.dart'
    as _i923;
import '../../presentation/role/student/tabs/home/presentation/view_model/student_notification/student_notification_view_model.dart'
    as _i150;
import '../../presentation/role/student/tabs/home/presentation/view_model/student_stats/student_stats_view_model.dart'
    as _i788;
import '../../presentation/role/student/tabs/lessons/data/data_source/lesson_progress/lesson_progress_remote_data_source.dart'
    as _i710;
import '../../presentation/role/student/tabs/lessons/data/data_source/lesson_progress/lesson_progress_supabase_data_source.dart'
    as _i487;
import '../../presentation/role/student/tabs/lessons/data/data_source/student_home_work/student_home_work_remote_data_source.dart'
    as _i968;
import '../../presentation/role/student/tabs/lessons/data/data_source/student_home_work/student_home_work_supabase_data_source.dart'
    as _i981;
import '../../presentation/role/student/tabs/lessons/data/repositories/lesson_progress/lesson_progress_repositories.dart'
    as _i541;
import '../../presentation/role/student/tabs/lessons/data/repositories/lesson_progress/lesson_progress_repositories_imp.dart'
    as _i1011;
import '../../presentation/role/student/tabs/lessons/data/repositories/student_home_work/student_home_work_repositories.dart'
    as _i1063;
import '../../presentation/role/student/tabs/lessons/data/repositories/student_home_work/student_home_work_repositories_imp.dart'
    as _i263;
import '../../presentation/role/student/tabs/lessons/domain/use_case/lesson_progress/lesson_progress_use_case.dart'
    as _i620;
import '../../presentation/role/student/tabs/lessons/domain/use_case/student_home_work/student_home_work_use_case.dart'
    as _i864;
import '../../presentation/role/student/tabs/lessons/presentation/view_model/lesson_progress/lesson_progress_view_model.dart'
    as _i1022;
import '../../presentation/role/student/tabs/lessons/presentation/view_model/student_home_work/student_home_work_view_model.dart'
    as _i489;
import '../../presentation/role/student/tabs/profile/data/data_source/student_notes/student_notes_remote_data_source.dart'
    as _i168;
import '../../presentation/role/student/tabs/profile/data/data_source/student_notes/student_supabase_data_source.dart'
    as _i597;
import '../../presentation/role/student/tabs/profile/data/repositories/student_notes/student_notes_repositories.dart'
    as _i113;
import '../../presentation/role/student/tabs/profile/data/repositories/student_notes/student_notes_repositories_imp.dart'
    as _i520;
import '../../presentation/role/student/tabs/profile/domain/use_case/student_notes/student_notes_use_case.dart'
    as _i1061;
import '../../presentation/role/student/tabs/profile/presentation/view_model/student_notes/student_notes_view_model.dart'
    as _i447;
import '../../presentation/role/teacher/tabs/dashboard/data/data_source/activities/activities_remote_data_source.dart'
    as _i749;
import '../../presentation/role/teacher/tabs/dashboard/data/data_source/activities/activities_supabase_data_source.dart'
    as _i967;
import '../../presentation/role/teacher/tabs/dashboard/data/data_source/analytics/analytics_remote_data_source.dart'
    as _i693;
import '../../presentation/role/teacher/tabs/dashboard/data/data_source/analytics/analytics_supabase_data_source.dart'
    as _i995;
import '../../presentation/role/teacher/tabs/dashboard/data/data_source/dashboard/dashboard_remote_data_source.dart'
    as _i802;
import '../../presentation/role/teacher/tabs/dashboard/data/data_source/dashboard/dashboard_supabase_data_source.dart'
    as _i891;
import '../../presentation/role/teacher/tabs/dashboard/data/data_source/exam/exam_remote_data_source.dart'
    as _i506;
import '../../presentation/role/teacher/tabs/dashboard/data/data_source/exam/exam_supabase_data_source.dart'
    as _i929;
import '../../presentation/role/teacher/tabs/dashboard/data/data_source/teacher_notification/teacher_notification_remote_data_source.dart'
    as _i77;
import '../../presentation/role/teacher/tabs/dashboard/data/data_source/teacher_notification/teacher_notification_supabase_data_source.dart'
    as _i418;
import '../../presentation/role/teacher/tabs/dashboard/data/repositories/activities/activities_repositories.dart'
    as _i497;
import '../../presentation/role/teacher/tabs/dashboard/data/repositories/activities/activities_repositories_imp.dart'
    as _i397;
import '../../presentation/role/teacher/tabs/dashboard/data/repositories/analytics/analytics_repositories.dart'
    as _i1028;
import '../../presentation/role/teacher/tabs/dashboard/data/repositories/analytics/analytics_repositories_imp.dart'
    as _i695;
import '../../presentation/role/teacher/tabs/dashboard/data/repositories/dashboard/dashboard_repositories.dart'
    as _i174;
import '../../presentation/role/teacher/tabs/dashboard/data/repositories/dashboard/dashboard_repositories_imp.dart'
    as _i122;
import '../../presentation/role/teacher/tabs/dashboard/data/repositories/exam/exam_repositories.dart'
    as _i796;
import '../../presentation/role/teacher/tabs/dashboard/data/repositories/exam/exam_repositories_imp.dart'
    as _i384;
import '../../presentation/role/teacher/tabs/dashboard/data/repositories/teacher_notification/teacher_notification_repositories.dart'
    as _i602;
import '../../presentation/role/teacher/tabs/dashboard/data/repositories/teacher_notification/teacher_notification_repositories_imp.dart'
    as _i487;
import '../../presentation/role/teacher/tabs/dashboard/domain/use_case/activities/activities_use_case.dart'
    as _i661;
import '../../presentation/role/teacher/tabs/dashboard/domain/use_case/analytics/analytics_use_case.dart'
    as _i113;
import '../../presentation/role/teacher/tabs/dashboard/domain/use_case/dashboard/dashboard_use_case.dart'
    as _i325;
import '../../presentation/role/teacher/tabs/dashboard/domain/use_case/exam/exam_use_case.dart'
    as _i817;
import '../../presentation/role/teacher/tabs/dashboard/domain/use_case/teacher_notification/teacher_notification_use_case.dart'
    as _i376;
import '../../presentation/role/teacher/tabs/dashboard/presentation/view_model/activities/activities_view_model.dart'
    as _i404;
import '../../presentation/role/teacher/tabs/dashboard/presentation/view_model/analytics/analytics_view_model.dart'
    as _i89;
import '../../presentation/role/teacher/tabs/dashboard/presentation/view_model/dashboard/dashboard_view_model.dart'
    as _i436;
import '../../presentation/role/teacher/tabs/dashboard/presentation/view_model/exam/exam_view_model.dart'
    as _i668;
import '../../presentation/role/teacher/tabs/dashboard/presentation/view_model/teacher_notification/teacher_notification_view_model.dart'
    as _i362;
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
import '../../presentation/role/teacher/tabs/teacher_profile/data/data_source/change_password/change_password_remote_data_source.dart'
    as _i919;
import '../../presentation/role/teacher/tabs/teacher_profile/data/data_source/change_password/change_password_supabase_data_source.dart'
    as _i829;
import '../../presentation/role/teacher/tabs/teacher_profile/data/data_source/teacher_profile/teacher_profile_remote_data_source.dart'
    as _i77;
import '../../presentation/role/teacher/tabs/teacher_profile/data/data_source/teacher_profile/teacher_profile_supabase_data_source.dart'
    as _i176;
import '../../presentation/role/teacher/tabs/teacher_profile/data/repositories/change_password/change_password_repositories.dart'
    as _i686;
import '../../presentation/role/teacher/tabs/teacher_profile/data/repositories/change_password/change_password_repositories_imp.dart'
    as _i56;
import '../../presentation/role/teacher/tabs/teacher_profile/data/repositories/teacher_profile/teacher_profile_repositories.dart'
    as _i8;
import '../../presentation/role/teacher/tabs/teacher_profile/data/repositories/teacher_profile/teacher_profile_repositories_imp.dart'
    as _i59;
import '../../presentation/role/teacher/tabs/teacher_profile/domain/use_case/change_password/change_password_use_case.dart'
    as _i100;
import '../../presentation/role/teacher/tabs/teacher_profile/domain/use_case/teacher_profile/teacher_profile_use_case.dart'
    as _i666;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/data/data_source/class_schedules_remote_data_source.dart'
    as _i267;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/data/data_source/class_schedules_supabase_data_source.dart'
    as _i173;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/data/repositories/class_schedules_repositories.dart'
    as _i816;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/data/repositories/class_schedules_repositories_imp.dart'
    as _i253;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/domain/use_case/class_schedules_use_case.dart'
    as _i728;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/presentation/view_model/class_schedules_view_model.dart'
    as _i175;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/data/data_source/grade_remote_data_source.dart'
    as _i80;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/data/data_source/grade_supabase_data_source.dart'
    as _i154;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/data/repositories/garde_repositories_imp.dart'
    as _i655;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/data/repositories/grade_repositories.dart'
    as _i394;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/domain/use_case/grade_use_case.dart'
    as _i322;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/presentation/view_model/grade_view_model.dart'
    as _i74;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/payment/data/data_source/payment_remote_data_source.dart'
    as _i110;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/payment/data/data_source/payment_supabase_data_source.dart'
    as _i536;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/payment/data/repositories/payment_repositories.dart'
    as _i835;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/payment/data/repositories/payment_repositories_imp.dart'
    as _i541;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/payment/domain/use_case/payment_use_case.dart'
    as _i391;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/payment/presentation/view_model/payment_view_model.dart'
    as _i52;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/data/data_source/subject_classes_remote_data_source.dart'
    as _i640;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/data/data_source/subject_classes_supabase_data_source.dart'
    as _i538;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/data/repositories/subject_classes_repositories.dart'
    as _i283;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/data/repositories/subject_classes_repositories_imp.dart'
    as _i842;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/domain/use_case/subject_classes_use_case.dart'
    as _i155;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/presentation/view_model/subject_classes_view_model.dart'
    as _i837;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view_model/change_password/change_password_view_model.dart'
    as _i335;
import '../../presentation/role/teacher/tabs/teacher_profile/presentation/view_model/teacher_profile/teacher_profile_view_model.dart'
    as _i1037;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i968.StudentHomeWorkRemoteDataSource>(
      () => _i981.StudentHomeWorkSupabaseDataSource(),
    );
    gh.lazySingleton<_i311.StudentNotificationRemoteDataSource>(
      () => _i337.StudentNotificationSupabaseDataSource(),
    );
    gh.lazySingleton<_i157.StudentNotificationRepositories>(
      () => _i249.StudentNotificationRepositoriesImp(
        studentNotificationRemoteDataSource:
            gh<_i311.StudentNotificationRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i749.ActivitiesRemoteDataSource>(
      () => _i967.ActivitiesSupabaseDataSource(),
    );
    gh.lazySingleton<_i506.ExamRemoteDataSource>(
      () => _i929.ExamSupabaseDataSource(),
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
    gh.lazySingleton<_i1063.StudentHomeWorkRepositories>(
      () => _i263.StudentHomeWorkRepositoriesImp(
        remoteDataSource: gh<_i968.StudentHomeWorkRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i77.TeacherProfileRemoteDataSource>(
      () => _i176.TeacherProfileSupabaseDataSource(),
    );
    gh.lazySingleton<_i168.StudentNotesRemoteDataSource>(
      () => _i597.StudentSupabaseDataSource(),
    );
    gh.lazySingleton<_i640.SubjectClassesRemoteDataSource>(
      () => _i538.SubjectClassesSupabaseDataSource(),
    );
    gh.lazySingleton<_i8.TeacherProfileRepositories>(
      () => _i59.TeacherProfileRepositoriesImp(
        remoteDataSource: gh<_i77.TeacherProfileRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i113.StudentNotesRepositories>(
      () => _i520.StudentNotesRepositoriesImp(
        remoteDataSource: gh<_i168.StudentNotesRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i919.ChangePasswordRemoteDataSource>(
      () => _i829.ChangePasswordSupabaseDataSource(),
    );
    gh.lazySingleton<_i53.ChatsRemoteDataSource>(
      () => _i480.ChatsSupabaseDataSource(),
    );
    gh.lazySingleton<_i77.TeacherNotificationRemoteDataSource>(
      () => _i418.TeacherNotificationSupabaseDataSource(),
    );
    gh.lazySingleton<_i686.ChangePasswordRepositories>(
      () => _i56.ChangePasswordRepositoriesImp(
        remoteDataSource: gh<_i919.ChangePasswordRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i80.GradeRemoteDataSource>(
      () => _i154.GradeSupabaseDataSource(),
    );
    gh.lazySingleton<_i802.DashboardRemoteDataSource>(
      () => _i891.DashboardSupabaseDataSource(),
    );
    gh.lazySingleton<_i394.GardeRepositories>(
      () => _i655.GardeRepositoriesImp(
        remoteDataSource: gh<_i80.GradeRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i129.StudentRemoteDataSource>(
      () => _i228.StudentSupabaseDataSource(),
    );
    gh.factory<_i100.ChangePasswordUseCase>(
      () => _i100.ChangePasswordUseCase(
        changePasswordRepositories: gh<_i686.ChangePasswordRepositories>(),
      ),
    );
    gh.factory<_i335.ChangePasswordCubit>(
      () => _i335.ChangePasswordCubit(
        changePasswordUseCase: gh<_i100.ChangePasswordUseCase>(),
      ),
    );
    gh.lazySingleton<_i110.PaymentRemoteDataSource>(
      () => _i536.PaymentSupabaseDataSource(),
    );
    gh.lazySingleton<_i710.LessonProgressRemoteDataSource>(
      () => _i487.LessonProgressSupabaseDataSource(),
    );
    gh.lazySingleton<_i556.StudentStatsRemoteDataSource>(
      () => _i1072.StudentStatsSupabaseDataSource(),
    );
    gh.lazySingleton<_i796.ExamRepositories>(
      () => _i384.ExamRepositoriesImp(
        remoteDataSource: gh<_i506.ExamRemoteDataSource>(),
      ),
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
    gh.factory<_i864.StudentHomeWorkUseCase>(
      () => _i864.StudentHomeWorkUseCase(
        repositories: gh<_i1063.StudentHomeWorkRepositories>(),
      ),
    );
    gh.lazySingleton<_i693.AnalyticsRemoteDataSource>(
      () => _i995.AnalyticsSupabaseDataSource(),
    );
    gh.lazySingleton<_i267.ClassSchedulesRemoteDataSource>(
      () => _i173.ClassSchedulesSupabaseDataSource(),
    );
    gh.factory<_i817.ExamUseCase>(
      () => _i817.ExamUseCase(repositories: gh<_i796.ExamRepositories>()),
    );
    gh.factory<_i489.StudentHomeWorkCubit>(
      () => _i489.StudentHomeWorkCubit(
        useCase: gh<_i864.StudentHomeWorkUseCase>(),
      ),
    );
    gh.factory<_i322.GradeUseCase>(
      () => _i322.GradeUseCase(repositories: gh<_i394.GardeRepositories>()),
    );
    gh.lazySingleton<_i200.TeacherRepositories>(
      () => _i466.TeacherRepositoriesImp(
        remoteDataSource: gh<_i617.TeacherRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i816.ClassSchedulesRepositories>(
      () => _i253.ClassSchedulesRepositoriesImp(
        remoteDataSource: gh<_i267.ClassSchedulesRemoteDataSource>(),
      ),
    );
    gh.factory<_i85.StudentNotificationUseCase>(
      () => _i85.StudentNotificationUseCase(
        studentNotificationRepositories:
            gh<_i157.StudentNotificationRepositories>(),
      ),
    );
    gh.factory<_i728.ClassSchedulesUseCase>(
      () => _i728.ClassSchedulesUseCase(
        classSchedulesRepositories: gh<_i816.ClassSchedulesRepositories>(),
      ),
    );
    gh.factory<_i74.GardeCubit>(
      () => _i74.GardeCubit(gradeUseCase: gh<_i322.GradeUseCase>()),
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
    gh.lazySingleton<_i835.PaymentRepositories>(
      () => _i541.PaymentRepositoriesImp(
        remoteDataSource: gh<_i110.PaymentRemoteDataSource>(),
      ),
    );
    gh.factory<_i436.DashboardCubit>(
      () => _i436.DashboardCubit(gh<_i802.DashboardRemoteDataSource>()),
    );
    gh.lazySingleton<_i174.DashboardRepositories>(
      () => _i122.DashboardRepositoriesImp(
        remoteDataSource: gh<_i802.DashboardRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i541.LessonProgressRepositories>(
      () => _i1011.LessonProgressRepositoriesImp(
        remoteDataSource: gh<_i710.LessonProgressRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i372.RegisterRepositories>(
      () => _i985.RegisterRepositoriesImp(
        remoteDataSource: gh<_i873.RegisterRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i869.StudentStatsRepositories>(
      () => _i864.StudentStatsRepositoriesImp(
        studentStatsRemoteDataSource: gh<_i556.StudentStatsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i1028.AnalyticsRepositories>(
      () => _i695.AnalyticsRepositoriesImp(
        remoteDataSource: gh<_i693.AnalyticsRemoteDataSource>(),
      ),
    );
    gh.factory<_i1061.StudentNotesUseCase>(
      () => _i1061.StudentNotesUseCase(
        repositories: gh<_i113.StudentNotesRepositories>(),
      ),
    );
    gh.factory<_i666.TeacherProfileUseCase>(
      () => _i666.TeacherProfileUseCase(
        teacherProfileRepositories: gh<_i8.TeacherProfileRepositories>(),
      ),
    );
    gh.lazySingleton<_i74.StudentRepositories>(
      () => _i593.StudentRepositoriesImp(
        remoteDataSource: gh<_i129.StudentRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i497.ActivitiesRepositories>(
      () => _i397.ActivitiesRepositoriesImp(
        remoteDataSource: gh<_i749.ActivitiesRemoteDataSource>(),
      ),
    );
    gh.factory<_i668.ExamCubit>(
      () => _i668.ExamCubit(examUseCase: gh<_i817.ExamUseCase>()),
    );
    gh.factory<_i93.TeacherUseCase>(
      () => _i93.TeacherUseCase(repositories: gh<_i200.TeacherRepositories>()),
    );
    gh.factory<_i447.StudentNotesCubit>(
      () => _i447.StudentNotesCubit(
        studentNotesUseCase: gh<_i1061.StudentNotesUseCase>(),
      ),
    );
    gh.factory<_i923.StudentStatsUseCase>(
      () => _i923.StudentStatsUseCase(
        studentStatsRepositories: gh<_i869.StudentStatsRepositories>(),
      ),
    );
    gh.factory<_i847.HomeWorkCubit>(
      () => _i847.HomeWorkCubit(useCase: gh<_i197.HomeWorkUseCase>()),
    );
    gh.lazySingleton<_i283.SubjectClassesRepositories>(
      () => _i842.SubjectClassesRepositoriesImp(
        remoteDataSource: gh<_i640.SubjectClassesRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i602.TeacherNotificationRepositories>(
      () => _i487.TeacherNotificationRepositoriesImp(
        remoteDataSource: gh<_i77.TeacherNotificationRemoteDataSource>(),
      ),
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
    gh.factory<_i391.PaymentUseCase>(
      () => _i391.PaymentUseCase(
        paymentRepositories: gh<_i835.PaymentRepositories>(),
      ),
    );
    gh.factory<_i1037.TeacherProfileCubit>(
      () => _i1037.TeacherProfileCubit(
        teacherProfileUseCase: gh<_i666.TeacherProfileUseCase>(),
      ),
    );
    gh.factory<_i175.ScheduleCubit>(
      () => _i175.ScheduleCubit(
        classSchedulesUseCase: gh<_i728.ClassSchedulesUseCase>(),
      ),
    );
    gh.factory<_i376.TeacherNotificationUseCase>(
      () => _i376.TeacherNotificationUseCase(
        teacherNotificationRepositories:
            gh<_i602.TeacherNotificationRepositories>(),
      ),
    );
    gh.factory<_i788.StudentStatsCubit>(
      () => _i788.StudentStatsCubit(
        studentStatsUseCase: gh<_i923.StudentStatsUseCase>(),
      ),
    );
    gh.factory<_i23.RegisterCubit>(
      () => _i23.RegisterCubit(registerUseCase: gh<_i266.RegisterUseCase>()),
    );
    gh.factory<_i150.StudentNotificationCubit>(
      () => _i150.StudentNotificationCubit(
        studentNotificationUseCase: gh<_i85.StudentNotificationUseCase>(),
      ),
    );
    gh.factory<_i362.TeacherNotificationCubit>(
      () => _i362.TeacherNotificationCubit(
        gh<_i376.TeacherNotificationUseCase>(),
      ),
    );
    gh.factory<_i325.DashboardUseCase>(
      () => _i325.DashboardUseCase(
        dashboardRepositories: gh<_i174.DashboardRepositories>(),
      ),
    );
    gh.factory<_i623.TeacherCubit>(
      () => _i623.TeacherCubit(teacherUseCase: gh<_i93.TeacherUseCase>()),
    );
    gh.factory<_i828.ChatsUseCase>(
      () => _i828.ChatsUseCase(repositories: gh<_i594.ChatsRepositories>()),
    );
    gh.factory<_i620.LessonProgressUseCase>(
      () => _i620.LessonProgressUseCase(
        lessonProgressRepositories: gh<_i541.LessonProgressRepositories>(),
      ),
    );
    gh.factory<_i1058.LoginCubit>(
      () => _i1058.LoginCubit(loginUseCase: gh<_i999.LoginUseCase>()),
    );
    gh.factory<_i551.TeacherLessonsCubit>(
      () => _i551.TeacherLessonsCubit(
        teacherLessonsUseCase: gh<_i213.TeacherLessonsUseCase>(),
      ),
    );
    gh.factory<_i1022.LessonProgressCubit>(
      () => _i1022.LessonProgressCubit(
        lessonProgressUseCase: gh<_i620.LessonProgressUseCase>(),
      ),
    );
    gh.factory<_i964.ChatsCubit>(
      () => _i964.ChatsCubit(chatsUseCase: gh<_i828.ChatsUseCase>()),
    );
    gh.factory<_i964.MessagesCubit>(
      () => _i964.MessagesCubit(chatsUseCase: gh<_i828.ChatsUseCase>()),
    );
    gh.factory<_i661.ActivitiesUseCase>(
      () => _i661.ActivitiesUseCase(
        activitiesRepositories: gh<_i497.ActivitiesRepositories>(),
      ),
    );
    gh.factory<_i113.AnalyticsUseCase>(
      () => _i113.AnalyticsUseCase(
        analyticsRepositories: gh<_i1028.AnalyticsRepositories>(),
      ),
    );
    gh.factory<_i406.StudentUseCase>(
      () => _i406.StudentUseCase(repositories: gh<_i74.StudentRepositories>()),
    );
    gh.factory<_i155.SubjectClassesUseCase>(
      () => _i155.SubjectClassesUseCase(
        repositories: gh<_i283.SubjectClassesRepositories>(),
      ),
    );
    gh.factory<_i342.StudentCubit>(
      () => _i342.StudentCubit(studentUseCase: gh<_i406.StudentUseCase>()),
    );
    gh.factory<_i404.ActivitiesCubit>(
      () => _i404.ActivitiesCubit(gh<_i661.ActivitiesUseCase>()),
    );
    gh.factory<_i52.PaymentCubit>(
      () => _i52.PaymentCubit(paymentUseCase: gh<_i391.PaymentUseCase>()),
    );
    gh.factory<_i89.AnalyticsCubit>(
      () => _i89.AnalyticsCubit(gh<_i113.AnalyticsUseCase>()),
    );
    gh.factory<_i837.SubjectClassesCubit>(
      () => _i837.SubjectClassesCubit(
        subjectClassesUseCase: gh<_i155.SubjectClassesUseCase>(),
      ),
    );
    return this;
  }
}
