import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class WeekDaySelector extends StatelessWidget {
  const WeekDaySelector({
    super.key,
    required this.weekDates,
    required this.selectedDate,
    required this.onSelected,
  });

  final List<DateTime> weekDates; 
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelected;

  static const _dayLabels = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(weekDates.length, (index) {
        final date = weekDates[index];
        final isSelected = _isSameDay(date, selectedDate);

        return Expanded(
          child: GestureDetector(
            onTap: () => onSelected(date),
            child: Column(
              children: [
                CustomText(
                  text: _dayLabels[index],
                  style: TextStyle(
                    color: isSelected
                        ? ColorManager.primary
                        : ColorManager.black.withValues(alpha: 0.4),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? ColorManager.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomText(
                    text: '${date.day}',
                    style: TextStyle(
                      color: isSelected ? Colors.white : ColorManager.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}