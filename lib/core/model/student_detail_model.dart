class StudentDetailsModel {
  final String name;
  final String grade;
  final String school;
  final int averageScore;
  final int lessons;
  final int attendance;
  final List<LessonProgress> lessonProgress;
  final ContactInfo contactInfo;
  final List<ExamResult> examResults;
  final List<StudentAttendanceRecord> attendanceRecords;

  const StudentDetailsModel({
    required this.name,
    required this.grade,
    required this.school,
    required this.averageScore,
    required this.lessons,
    required this.attendance,
    required this.lessonProgress,
    required this.contactInfo,
    required this.examResults,
    required this.attendanceRecords,
  });
}

class LessonProgress {
  final String name;
  final int progress; // 0-100

  const LessonProgress({required this.name, required this.progress});
}

class ContactInfo {
  final String phone;
  final String parentPhone;
  final String email;

  const ContactInfo({
    required this.phone,
    required this.parentPhone,
    required this.email,
  });
}

class ExamResult {
  final String title;
  final int score; // out of 100
  final double avgPercent;
  final double passRatePercent;

  const ExamResult({
    required this.title,
    required this.score,
    required this.avgPercent,
    required this.passRatePercent,
  });
}

enum StudentAttendanceStatus { present, absent, late }

class StudentAttendanceRecord {
  final DateTime date;
  final StudentAttendanceStatus status;

  const StudentAttendanceRecord({required this.date, required this.status});
}

class DummyStudentDetailsData {
  static StudentDetailsModel jamesWilson = StudentDetailsModel(
    name: 'James Wilson',
    grade: 'Grade 11',
    school: 'Excellence Academy',
    averageScore: 72,
    lessons: 18,
    attendance: 85,
    lessonProgress: const [
      LessonProgress(name: 'Calculus: Derivatives ...', progress: 100),
      LessonProgress(name: 'Quantum Mechanics Intr...', progress: 60),
      LessonProgress(name: 'Integration Techniques...', progress: 0),
      LessonProgress(name: 'Electromagnetic Fields...', progress: 25),
      LessonProgress(name: 'Linear Algebra Fundame...', progress: 0),
    ],
    contactInfo: const ContactInfo(
      phone: '+1 555-0301',
      parentPhone: '+1 555-0302',
      email: 'james@student.com',
    ),
    examResults: const [
      ExamResult(title: 'Physics Quiz #3', score: 87, avgPercent: 81, passRatePercent: 85),
    ],
    attendanceRecords: [
      StudentAttendanceRecord(date: DateTime(2026, 1, 17), status: StudentAttendanceStatus.present),
      StudentAttendanceRecord(date: DateTime(2026, 1, 16), status: StudentAttendanceStatus.present),
      StudentAttendanceRecord(date: DateTime(2026, 1, 15), status: StudentAttendanceStatus.absent),
      StudentAttendanceRecord(date: DateTime(2026, 1, 14), status: StudentAttendanceStatus.late),
    ],
  );
}