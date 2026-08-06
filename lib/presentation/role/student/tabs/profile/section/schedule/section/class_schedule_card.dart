import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/model/class_schedule_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import 'class_type_style.dart';

class ClassScheduleCard extends StatelessWidget {
  const ClassScheduleCard({super.key, required this.classItem});

  final ClassScheduleModel classItem;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final typeStyle = ClassTypeStyle.of(classItem.type, l10);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 10),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: typeStyle.color,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: classItem.title,
                        style: TextStyle(
                          color: ColorManager.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: typeStyle.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CustomText(
                        text: typeStyle.label,
                        style: TextStyle(
                          color: typeStyle.color,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: classItem.subject,
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.6),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: ColorManager.black.withValues(alpha: 0.4),
                    ),
                    const SizedBox(width: 4),
                    CustomText(
                      text: classItem.time,
                      style: TextStyle(
                        color: ColorManager.black.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: ColorManager.black.withValues(alpha: 0.4),
                    ),
                    const SizedBox(width: 4),
                    CustomText(
                      text: classItem.room,
                      style: TextStyle(
                        color: ColorManager.black.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
