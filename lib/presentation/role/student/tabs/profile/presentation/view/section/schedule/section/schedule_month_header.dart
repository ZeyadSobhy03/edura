import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'week_day_selector.dart';

class ScheduleMonthHeader extends StatelessWidget {
  const ScheduleMonthHeader({
    super.key,
    required this.displayedMonth,
    required this.weekDates,
    required this.selectedDate,
    required this.onDaySelected,
    required this.onCalendarTap,
  });

  final DateTime displayedMonth;
  final List<DateTime> weekDates;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDaySelected;
  final VoidCallback onCalendarTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: DateFormat('MMMM yyyy').format(displayedMonth),
                style: TextStyle(
                  color: ColorManager.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: onCalendarTap,
                child: Icon(
                  Icons.calendar_today_outlined,
                  color: ColorManager.primary,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          WeekDaySelector(
            weekDates: weekDates,
            selectedDate: selectedDate,
            onSelected: onDaySelected,
          ),
        ],
      ),
    );
  }
}