import 'package:flutter/material.dart';

class ClassSchedule {
  final String id;
  final String gradeId;
  final int dayOfWeek; // 0 = Sunday
  final TimeOfDay start;
  final TimeOfDay end;

  const ClassSchedule({
    required this.id,
    required this.gradeId,
    required this.dayOfWeek,
    required this.start,
    required this.end,
  });

  factory ClassSchedule.fromJson(Map<String, dynamic> json) => ClassSchedule(
    id: json['id'] as String,
    gradeId: json['grade_id'] as String,
    dayOfWeek: (json['day_of_week'] as num).toInt(),
    start: _parse(json['start_time'] as String),
    end: _parse(json['end_time'] as String),
  );

  static TimeOfDay _parse(String s) {
    final p = s.split(':');
    return TimeOfDay(hour: int.parse(p[0]), minute: int.parse(p[1]));
  }

  static String toDb(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}:00';
}