import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/section/teacher_profile_body.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/section/teacher_profile_header.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view_model/teacher_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../../../../../student/tabs/profile/section/settings/sections/settings_group_card.dart';
import '../../../../../student/tabs/profile/section/settings/widgets/settings_tile.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({super.key});

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  String? teacherId;

  @override
  void initState() {
    super.initState();
    final currentUser = Supabase.instance.client.auth.currentUser;

    if (currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, RouteManger.loginRoute);
      });
      return;
    }

    teacherId = currentUser.id;
    context.read<TeacherProfileCubit>().getTeacherProfile(teacherId!);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: BlocBuilder<TeacherProfileCubit, TeacherProfileState>(
          builder: (context, state) {
            if (state is TeacherProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            } else if (state is TeacherProfileError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(
                    color: ColorManager.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else if (state is TeacherProfileLoaded) {
              final teacher = state.profile;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TeacherProfileHeader(
                      teacher: teacher,
                      onEditPressed: () {
                        Navigator.pushNamed(
                          context,
                          RouteManger.teacherEditProfileScreen,
                          arguments: teacher,
                        );
                      },
                    ),
                    const SizedBox(height: 44),
                    TeacherProfileBody(
                      teacher: teacher,
                      lessonsCount: teacher.lessonsCount.toString(),
                      examsCount: teacher.examsCount.toString(),
                      homeworkCount: teacher.homeworkCount.toString(),
                    ),
                    const SizedBox(height: 44),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SettingsGroupCard(
                        children: [
                          SettingsTile(
                            icon: Icons.logout,
                            title: l10.logout,
                            isDestructive: true,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
