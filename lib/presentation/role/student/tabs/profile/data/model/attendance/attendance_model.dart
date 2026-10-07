enum AttendanceStatus { present, absent, late }

class AttendanceRecordModel {
  final String id;
  final DateTime date;
  final String subject;
  final String teacherName;
  final AttendanceStatus status;

  AttendanceRecordModel({
    required this.id,
    required this.date,
    required this.subject,
    required this.teacherName,
    required this.status,
  });

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return AttendanceRecordModel(
      id: json['id'].toString(),
      date: DateTime.parse(json['date'] as String),
      subject: json['subject'] ?? '',
      teacherName: json['teacher_name'] ?? '',
      status: AttendanceStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => AttendanceStatus.present,
      ),
    );
  }
}

class MonthlyAttendanceModel {
  final DateTime month;
  final double rate;

  MonthlyAttendanceModel({required this.month, required this.rate});
}