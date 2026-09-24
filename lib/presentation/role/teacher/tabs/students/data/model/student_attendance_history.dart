class StudentAttendanceHistory {
  final String studentId;
  final String studentName;
  final List<AttendanceEntry> records;

  const StudentAttendanceHistory({
    required this.studentId,
    required this.studentName,
    required this.records,
  });

  factory StudentAttendanceHistory.fromJson(Map<String, dynamic> json) {
    final rawRecords = json['student_attendance'] as List? ?? [];
    final records = rawRecords
        .map((e) => AttendanceEntry.fromJson(e as Map<String, dynamic>))
        .toList();

    records.sort((a, b) => b.date.compareTo(a.date));

    return StudentAttendanceHistory(
      studentId: json['id'] as String,
      studentName: json['name'] as String? ?? '',
      records: records,
    );
  }
}

class AttendanceEntry {
  final DateTime date;
  final String status;

  const AttendanceEntry({required this.date, required this.status});

  factory AttendanceEntry.fromJson(Map<String, dynamic> json) {
    return AttendanceEntry(
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
    );
  }
}