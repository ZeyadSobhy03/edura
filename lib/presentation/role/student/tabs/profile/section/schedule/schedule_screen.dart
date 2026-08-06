import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/schedule/section/schedule_month_header.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/model/class_schedule_model.dart';
import '../../../../../../../l10n/app_localizations.dart';
import 'section/class_schedule_card.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  List<DateTime> _weekDatesFor(DateTime date) {
    final monday = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (i) => monday.add(Duration(days: i)));
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  List<dynamic> get _classesForSelectedDay {
    return DummyScheduleData.all
        .where((c) => _isSameDay(c.date, _selectedDate))
        .toList();
  }

  Future<void> _openCalendarPicker() async {
    final picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorManager.primary,
              onPrimary: ColorManager.white,
              onSurface: ColorManager.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorManager.primary,
              ),
            ),
          ),
          child: child!,
        );
      },

      context: context,
      initialDate: _selectedDate,

      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final classes = _classesForSelectedDay;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.schedule,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScheduleMonthHeader(
                displayedMonth: _selectedDate,
                weekDates: _weekDatesFor(_selectedDate),
                selectedDate: _selectedDate,
                onDaySelected: (date) => setState(() => _selectedDate = date),
                onCalendarTap: _openCalendarPicker,
              ),
              const SizedBox(height: 20),
              CustomText(
                text: l10.todaysClasses,
                style: TextStyle(
                  color: ColorManager.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              if (classes.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: CustomText(
                      text: l10.noClassesToday,
                      style: TextStyle(
                        color: ColorManager.black.withValues(alpha: 0.5),
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              else
                ...classes.map((c) => ClassScheduleCard(classItem: c)),
            ],
          ),
        ),
      ),
    );
  }
}
