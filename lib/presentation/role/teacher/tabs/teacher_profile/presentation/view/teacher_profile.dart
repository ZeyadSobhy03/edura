import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/section/teacher_profile_body.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/section/teacher_profile_header.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view_model/teacher_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherProfile extends StatelessWidget {
  const TeacherProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: BlocBuilder<TeacherProfileCubit, TeacherProfileState>(
          builder: (context, state) {
            switch (state) {
              case TeacherProfileInitial():
              case TeacherProfileLoading():
                return const Center(
                  child: CircularProgressIndicator(color: ColorManager.primary),
                );

              case TeacherProfileError(message: final message):
                return Center(child: Text(message));

              case TeacherProfileLoaded(profile: final teacher):
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
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
