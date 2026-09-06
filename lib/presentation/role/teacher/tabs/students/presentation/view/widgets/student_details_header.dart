import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../data/model/student_detail_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';



class StudentDetailsHeader extends StatelessWidget {
  const StudentDetailsHeader({super.key, required this.student});

  final StudentModel student;

  String get _initials {
    final parts = student.name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts.isNotEmpty ? parts[0][0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  child: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                ),
              ),
              Expanded(
                child: Center(
                  child: CustomText(
                    text: l10.studentDetails,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 36), // balances the back button so title stays centered
            ],
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                child: CustomText(
                  text: _initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: student.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  CustomText(
                    text: student.grade,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13),
                  ),
                  CustomText(
                    text: student.school,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              _headerStat('${student.averageScore}%', l10.avgScore),
              const SizedBox(width: 28),
              _headerStat('${student.lessons}', l10.lessons),
              const SizedBox(width: 28),
              _headerStat('${student.attendance}%', l10.attendance),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: value,
          style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        CustomText(
          text: label,
          style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 11),
        ),
      ],
    );
  }
}