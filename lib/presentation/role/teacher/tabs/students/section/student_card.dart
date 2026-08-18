import 'package:edura/core/model/student_detail_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/teacher/tabs/students/widgets/details_row.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.student, this.onTap});

  final StudentDetailsModel student;
  final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,

        color: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: ColorManager.black.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: ColorManager.blue.withValues(alpha: 0.15),
                child: CustomText(
                  text: student.name.isNotEmpty
                      ? student.name[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    color: ColorManager.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: student.name,
                      style: TextStyle(
                        color: ColorManager.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    CustomText(
                      text: student.grade,
                      style: TextStyle(
                        color: ColorManager.salatGray,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailsRow(
                          icon: Icons.star,
                          text: '${student.averageScore}%',
                        ),
                        DetailsRow(icon: Icons.flash_on, text: '28d'),
                        DetailsRow(
                          haveIcon: false,
                          text: "${student.attendance}",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onTap,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: ColorManager.black.withValues(alpha: 0.5),
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
