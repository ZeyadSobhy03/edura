import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/presentation/auth/log_out/presentation/view_model/log_out_view_model.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view/section/logout_button.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view/section/profile_body.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view/section/profile_header.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view/section/profile_state_row.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view_model/student_profile/student_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? studentId;

  @override
  void initState() {
    super.initState();

    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, RouteManger.loginRoute);
        }
      });
      return;
    }

    studentId = currentUser.id;
    context.read<StudentProfileCubit>().getStudentProfile(studentId: studentId!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogOutCubit, LogOutState>(
      listener: (context, state) {
        if (state is LogOutSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteManger.loginRoute,
            (route) => false,
          );
        } else if (state is LogOutFailure) {
         Fluttertoast.showToast(
            msg: state.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: ColorManager.red,
            textColor: ColorManager.white,
          );
        }
      },
      builder: (context, logoutState) {
        return Scaffold(
          backgroundColor: ColorManager.white,
          body: SafeArea(
            child: BlocBuilder<StudentProfileCubit, StudentProfileState>(
              builder: (context, state) {
                if (state is StudentProfileLoading || state is StudentProfileInitial) {
                  return const Center(
                    child: CircularProgressIndicator(color: ColorManager.primary),
                  );
                }

                if (state is StudentProfileError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(
                        color: ColorManager.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (state is StudentProfileLoaded) {
                  final student = state.student;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ProfileHeader(
                          userGrade: student.grade,
                          userName: student.name,
                        ),
                        const SizedBox(height: 8),
                        ProfileStateRow(
                          numberOfLessons: student.lessons,
                          averageScore: student.averageScore,
                          rank: student.rank,
                          points: student.points,
                        ),
                        const ProfileBody(),
                        const SizedBox(height: 16),
                        LogoutButton(
                          onPressed: logoutState is LogOutLoading
                              ? null
                              : () => context.read<LogOutCubit>().logOut(),
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
      },
    );
  }
}
