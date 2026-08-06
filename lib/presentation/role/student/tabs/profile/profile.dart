import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/logout_button.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/profile_body.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/profile_header.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/profile_state_row.dart';
import 'package:flutter/material.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              ProfileHeader(userGrade: "Grade 10", userName: "Ziyad Sobhy"),
              const SizedBox(height: 8),
              ProfileStateRow(
                numberOfLessons: 10,
                averageScore: 20,
                rank: 1,
                points: 300,
              ),
              ProfileBody(),
              SizedBox(height: 16),
              LogoutButton(onPressed: (){},)
            ],
          ),
        ),
      ),
    );
  }
}
