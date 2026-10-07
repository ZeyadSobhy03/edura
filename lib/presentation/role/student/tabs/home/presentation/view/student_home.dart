import 'package:edura/core/localization/error_messages.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_label.dart';
import 'package:edura/core/widgets/custom_text_button.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/role/student/tabs/home/presentation/view/section/stats/announcement_state.dart';
import 'package:edura/presentation/role/student/tabs/home/presentation/view/section/stats/stats_section.dart';
import 'package:edura/presentation/role/student/tabs/home/presentation/view/section/stats/up_next_lesson.dart';
import 'package:edura/presentation/role/student/tabs/home/presentation/view/widgets/home_header.dart';
import 'package:edura/presentation/role/student/tabs/home/presentation/view/widgets/quick_action_card.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view_model/student_profile/student_profile_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view_model/lessons/teacher_lessons_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/widgets/custom_text.dart';
import '../../../lessons/presentation/view/section/lesson_grid_card.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  String? studentId;
  String? studentName;
  String? grade;

  @override
  void initState() {
    super.initState();

    studentId = Supabase.instance.client.auth.currentUser?.id;

    grade =
        Supabase.instance.client.auth.currentUser?.userMetadata?['grade']
            as String?;

    if (studentId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, RouteManger.loginRoute);
        }
      });
    }
    context.read<TeacherLessonsCubit>().fetchLessonByGrade(grade!);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final id = studentId;

    if (id == null) {
      return Scaffold(backgroundColor: ColorManager.white);
    }

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<StudentProfileCubit, StudentProfileState>(
                builder: (context, state) {
                  if (state is StudentProfileLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primary,
                      ),
                    );
                  }
                  if (state is StudentProfileError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: ColorManager.red),
                      ),
                    );
                  }
                  if (state is StudentProfileLoaded) {
                    studentName = state.student.name;
                    return HomeHeader(
                      userName: studentName ?? '',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteManger.studentNotificationScreen,
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 8),

              StatsSection(studentId: id),

              const SizedBox(height: 8),

              BlocBuilder<TeacherLessonsCubit, TeacherLessonsState>(
                builder: (context, state) {
                  if (state is TeacherLessonsLoading ||
                      state is TeacherLessonsInitial) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primary,
                      ),
                    );
                  }
                  if (state is TeacherLessonsFailure) {
                    return Center(
                      child: Text(
                        ErrorMessages.get(context, state.error),
                        style: const TextStyle(color: ColorManager.red),
                      ),
                    );
                  }
                  if (state is TeacherLessonsLoaded) {
                    final lessons = state.publishedLessons;
                    if (lessons.isEmpty) {
                      return Center(
                        child: CustomText(
                          text: l10.noLessons,
                          style: TextStyle(color: ColorManager.gray),
                        ),
                      );
                    }
                    return UpNextLesson(
                      key: ValueKey(lessons.first.id),
                      lesson: lessons.first,

                      studentId: id,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 8),
              CustomLabel(label: l10.quickActions),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: QuickActionCard(
                      label: l10.lessons,
                      icon: Icons.menu_book,
                      color: ColorManager.primary,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteManger.studentMainLayoutRoute,
                          arguments: 1,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: QuickActionCard(
                      label: l10.exams,
                      icon: Icons.assignment,
                      color: ColorManager.purple,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteManger.studentMainLayoutRoute,
                          arguments: 2,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: QuickActionCard(
                      label: l10.chat,
                      icon: Icons.chat_bubble_outline,
                      color: ColorManager.orange,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteManger.studentMainLayoutRoute,
                          arguments: 3,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: QuickActionCard(
                      label: l10.schedule,
                      icon: Icons.schedule,
                      color: ColorManager.green,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteManger.studentMainLayoutRoute,
                          arguments: 4,
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              Row(
                children: [
                  CustomLabel(label: l10.recentLessons),
                  const Spacer(),
                  CustomTextButton(
                    text: l10.viewAll,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.studentMainLayoutRoute,
                        arguments: 1,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),

              BlocBuilder<TeacherLessonsCubit, TeacherLessonsState>(
                builder: (context, state) {
                  if (state is TeacherLessonsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primary,
                      ),
                    );
                  }
                  if (state is TeacherLessonsFailure) {
                    return Center(
                      child: Text(
                        ErrorMessages.get(context, state.error),
                        style: const TextStyle(color: ColorManager.red),
                      ),
                    );
                  }
                  if (state is TeacherLessonsLoaded) {
                    final lessons = state.publishedLessons.take(3).toList();
                    if (lessons.isEmpty) {
                      return Center(
                        child: CustomText(
                          text: l10.noLessons,
                          style: TextStyle(color: ColorManager.gray),
                        ),
                      );
                    }
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lessons.length,
                        itemBuilder: (context, index) {
                          final lesson = lessons[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SizedBox(
                              width: 160,
                              child: LessonGridCard(
                                lesson: lesson,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteManger.lessonDetails,
                                    arguments: lesson,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 8),
              Row(
                children: [
                  CustomLabel(label: l10.announcements),
                  const Spacer(),
                  CustomTextButton(
                    text: l10.viewAll,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.announcementsScreen,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const AnnouncementState(),
            ],
          ),
        ),
      ),
    );
  }
}
