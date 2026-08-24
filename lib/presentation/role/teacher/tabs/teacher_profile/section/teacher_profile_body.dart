import 'package:edura/core/model/teacher_profile_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/section/profile_actions.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/section/teacher_detail.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/section/teacher_info_row.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/section/teacher_stat_row.dart';
import 'package:flutter/material.dart';

class TeacherProfileBody extends StatelessWidget {
  const TeacherProfileBody({
    super.key,
    required this.teacher,
    required this.lessonsCount,
    required this.examsCount,
    required this.homeworkCount,
  });

  final TeacherProfileModel teacher;
  final String lessonsCount;
  final String examsCount;
  final String homeworkCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TeacherDetail(
                teacherName: teacher.name,
                teacherSubject: teacher.subject,
              ),
              const SizedBox(height: 12),
              TeacherInfoRow(teacher: teacher),
              const SizedBox(height: 20),
              TeacherStatRow(
                lessonsCount: lessonsCount,
                examsCount: examsCount,
                homeworkCount: homeworkCount,
              ),
              const SizedBox(height: 12),
              ProfileActions(
                teacher: teacher,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
