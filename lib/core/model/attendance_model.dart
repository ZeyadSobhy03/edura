enum AttendanceStatus { present, absent, late }

class AttendanceRecordModel {
  final String id;
  final DateTime date;
  final String subject;
  final String room;
  final AttendanceStatus status;

  AttendanceRecordModel({
    required this.id,
    required this.date,
    required this.subject,
    required this.room,
    required this.status,
  });

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return AttendanceRecordModel(
      id: json['id'].toString(),
      date: DateTime.parse(json['date']),
      subject: json['subject'] ?? '',
      room: json['room'] ?? '',
      status: AttendanceStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => AttendanceStatus.present,
      ),
    );
  }
}

class MonthlyAttendanceModel {
  final String monthLabel;
  final double attendanceRate;

  MonthlyAttendanceModel({
    required this.monthLabel,
    required this.attendanceRate,
  });
}

class DummyAttendanceData {
  static List<MonthlyAttendanceModel> monthlyTrend = [
    MonthlyAttendanceModel(monthLabel: 'Jul', attendanceRate: 0.3),
    MonthlyAttendanceModel(monthLabel: 'Aug', attendanceRate: 0.25),
    MonthlyAttendanceModel(monthLabel: 'Sep', attendanceRate: 0.2),
    MonthlyAttendanceModel(monthLabel: 'Oct', attendanceRate: 0.2),
    MonthlyAttendanceModel(monthLabel: 'Nov', attendanceRate: 0.25),
    MonthlyAttendanceModel(monthLabel: 'Dec', attendanceRate: 0.2),
    MonthlyAttendanceModel(monthLabel: 'Jan', attendanceRate: 1.0),
  ];

  static List<AttendanceRecordModel> records = [
    AttendanceRecordModel(
      id: '1',
      date: DateTime(2026, 1, 17),
      subject: 'Mathematics',
      room: 'Room 204',
      status: AttendanceStatus.present,
    ),
    AttendanceRecordModel(
      id: '2',
      date: DateTime(2026, 1, 16),
      subject: 'Mathematics',
      room: 'Room 204',
      status: AttendanceStatus.present,
    ),
    AttendanceRecordModel(
      id: '3',
      date: DateTime(2026, 1, 15),
      subject: 'Mathematics',
      room: 'Room 204',
      status: AttendanceStatus.absent,
    ),
    AttendanceRecordModel(
      id: '4',
      date: DateTime(2026, 1, 14),
      subject: 'Mathematics',
      room: 'Room 204',
      status: AttendanceStatus.late,
    ),
  ];
}