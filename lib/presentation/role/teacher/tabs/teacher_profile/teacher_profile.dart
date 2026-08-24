import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';

import 'package:edura/presentation/role/teacher/tabs/teacher_profile/section/teacher_profile_body.dart';
import 'package:flutter/material.dart';

import '../../../../../core/model/teacher_profile_model.dart';
import 'section/teacher_profile_header.dart';

class TeacherProfile extends StatelessWidget {
  const TeacherProfile({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherProfileModel teacher = TeacherProfileModel(
      name: 'زياد صبحي',
      subject: 'مدرس لغة عربية',
      studentsCount: 120,
      rating: 4.8,
      yearsExperience: 6,
    );

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                lessonsCount: "5",
                examsCount: "4",
                homeworkCount: "6",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
