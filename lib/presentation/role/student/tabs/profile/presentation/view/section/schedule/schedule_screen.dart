import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view/section/schedule/section/schedule_month_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../l10n/app_localizations.dart';
import '../../../view_model/schedule/schedule_view_model.dart';
import 'section/class_schedule_card.dart';

int _dbDay(DateTime date) => date.weekday;

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
    context.read<StudentScheduleCubit>().load();
  }

  List<DateTime> _weekDatesFor(DateTime date) {
    final monday = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (i) => monday.add(Duration(days: i)));
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
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

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
        child: RefreshIndicator(
          onRefresh: () => context.read<StudentScheduleCubit>().load(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                BlocBuilder<StudentScheduleCubit, StudentScheduleState>(
                  builder: (context, state) {
                    if (state is StudentScheduleLoading) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.primary,
                          ),
                        ),
                      );
                    }
                    if (state is StudentScheduleError) {
                      return Center(
                        child: Column(
                          children: [
                            Text(state.message, textAlign: TextAlign.center),
                            TextButton(
                              onPressed: () =>
                                  context.read<StudentScheduleCubit>().load(),
                              child:  Text(l10.retry),
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is! StudentScheduleLoaded) {
                      return const SizedBox.shrink();
                    }

                    final classes = state.classes
                        .where((c) => c.dayOfWeek == _dbDay(_selectedDate))
                        .toList();

                    if (classes.isEmpty) {
                      return Padding(
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
                      );
                    }

                    return Column(
                      children: classes
                          .map((c) => ClassScheduleCard(classItem: c))
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
