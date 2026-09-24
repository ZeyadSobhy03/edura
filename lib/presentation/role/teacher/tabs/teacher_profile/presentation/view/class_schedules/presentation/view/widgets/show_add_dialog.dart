import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/class_schedules_view_model.dart';

Future<void> showAddScheduleDialog({
  required BuildContext context,
  required String gradeId,
  required ScheduleCubit scheduleCubit,
}) async {
  int day = 0;
  TimeOfDay? start;
  TimeOfDay? end;
  String? error;

  await showDialog(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setLocal) {
        final loc = AppLocalizations.of(context)!;
        final days = [
          loc.sunday,
          loc.monday,
          loc.tuesday,
          loc.wednesday,
          loc.thursday,
          loc.friday,
          loc.saturday,
        ];

        return AlertDialog(
          backgroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(loc.addClassSchedule),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                dropdownColor: ColorManager.white,

                initialValue: day,
                decoration: InputDecoration(labelText: loc.dayOfWeek),
                items: [
                  for (var i = 0; i < 7; i++)
                    DropdownMenuItem(value: i, child: Text(days[i])),
                ],
                onChanged: (v) {
                  setLocal(() => day = v ?? 0);
                },
              ),

              const SizedBox(height: 12),

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: ColorManager.primary),
                ),
                onPressed: () async {
                  final t = await showTimePicker(
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                          colorScheme: ColorScheme.light(
                            primary: ColorManager.primary,
                            onPrimary: ColorManager.white,
                            onSurface: ColorManager.black,
                          ),
                        ),
                        child: child!,
                      );
                    },
                    context: context,
                    initialTime: start ?? const TimeOfDay(hour: 16, minute: 0),
                  );

                  if (t != null) {
                    setLocal(() => start = t);
                  }
                },
                child: Text(
                  start == null ? loc.startTime : start!.format(context),
                  style: TextStyle(color: ColorManager.primary),
                ),
              ),

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: ColorManager.primary),
                ),
                onPressed: () async {
                  final t = await showTimePicker(
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                          colorScheme: ColorScheme.light(
                            primary: ColorManager.primary,
                            onPrimary: ColorManager.white,
                            onSurface: ColorManager.black,
                          ),
                        ),
                        child: child!,
                      );
                    },
                    context: context,
                    initialTime: end ?? const TimeOfDay(hour: 17, minute: 0),
                  );

                  if (t != null) {
                    setLocal(() => end = t);
                  }
                },
                child: Text(end == null ? loc.endTime : end!.format(context),
                style: TextStyle(color: ColorManager.primary),

                ),
              ),

              if (error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    error!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                loc.cancel,
                style: TextStyle(color: ColorManager.black),
              ),
            ),

            TextButton(
              onPressed: () {
                if (start == null || end == null) {
                  setLocal(() => error = loc.chooseStartAndEndTime);
                  return;
                }

                final s = start!.hour * 60 + start!.minute;
                final e = end!.hour * 60 + end!.minute;

                if (e <= s) {
                  setLocal(() => error = loc.endMustBeAfterStart);
                  return;
                }

                scheduleCubit.add(
                  gradeId: gradeId,
                  dayOfWeek: day,
                  start: start!,
                  end: end!,
                );

                Navigator.pop(dialogContext);
              },
              child: Text(
                loc.save,
                style: TextStyle(color: ColorManager.primary),
              ),
            ),
          ],
        );
      },
    ),
  );
}
