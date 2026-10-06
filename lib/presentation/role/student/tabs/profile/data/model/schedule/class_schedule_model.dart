class ClassScheduleModel {
  final String id;
  final String teacherName;
  final String subject;
  final int dayOfWeek;
  final String startTime;
  final String endTime;

  ClassScheduleModel({
    required this.id,
    required this.teacherName,
    required this.subject,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  static String _format(String t) {
    final parts = t.split(':');
    final h = int.tryParse(parts[0]) ?? 0;
    final m = parts.length > 1 ? parts[1] : '00';
    final h12 = h % 12 == 0 ? 12 : h % 12;
    return '$h12:$m ${h < 12 ? 'AM' : 'PM'}';
  }

  String get timeRange => '$startTime - $endTime';

  factory ClassScheduleModel.fromJson(Map<String, dynamic> json) {
    return ClassScheduleModel(
      id: json['id'].toString(),
      teacherName: json['teacher_name'] ?? '',
      subject: json['subject'] ?? '',
      dayOfWeek: (json['day_of_week'] as num).toInt(),
      startTime: _format(json['start_time'] as String),
      endTime: _format(json['end_time'] as String),
    );
  }
}