import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/class_schedules/data/model/class_schedules.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../../../../core/widgets/custom_text.dart';

class SchedulesTile extends StatelessWidget {
  const SchedulesTile({
    super.key,
    required this.day,
    required this.onDelete,
    required this.schedule,
  });

  final String day;
  final VoidCallback onDelete;

  final ClassSchedule schedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: day,
                  style: TextStyle(
                    color: ColorManager.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomText(
                  text:
                      '${schedule.start.format(context)} - ${schedule.end.format(context)}',
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
