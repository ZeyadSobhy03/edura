class StudentModel {
  final String id;
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

  const StudentModel({
    required this.id,
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

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      grade: json['grade'] as String? ?? '',
      school: json['school'] as String? ?? '',

      // Supabase columns
      averageScore: json['average_score'] as int? ?? 0,
      lessons: json['lessons'] as int? ?? 0,
      attendance: json['attendance'] as int? ?? 0,

      // Details are not returned from students table yet
      lessonProgress: (json['lessonProgress'] as List?)
          ?.map(
            (e) => LessonProgress.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList() ??
          const [],

      contactInfo: json['contactInfo'] != null
          ? ContactInfo.fromJson(
        json['contactInfo'] as Map<String, dynamic>,
      )
          : const ContactInfo(
        phone: '',
        parentPhone: '',
        email: '',
      ),

      examResults: (json['examResults'] as List?)
          ?.map(
            (e) => ExamResult.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList() ??
          const [],

      attendanceRecords: (json['attendanceRecords'] as List?)
          ?.map(
            (e) => StudentAttendanceRecord.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList() ??
          const [],
    );
  }
  factory StudentModel.fromDetailsJson(Map<String, dynamic> json) {
    final contacts = json['student_contacts'] as List? ?? [];

    final contact = contacts.isNotEmpty
        ? contacts.first as Map<String, dynamic>
        : <String, dynamic>{};

    final lessonProgressJson =
        json['student_lesson_progress'] as List? ?? [];

    final examResultsJson =
        json['exam_results'] as List? ?? [];

    final attendanceJson =
        json['student_attendance'] as List? ?? [];

    return StudentModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      grade: json['grade'] as String? ?? '',
      school: json['school'] as String? ?? '',
      averageScore: json['average_score'] as int? ?? 0,
      lessons: json['lessons'] as int? ?? 0,
      attendance: json['attendance'] as int? ?? 0,

      contactInfo: ContactInfo(
        phone: contact['phone'] as String? ?? '',
        parentPhone: contact['parent_phone'] as String? ?? '',
        email: contact['email'] as String? ?? '',
      ),

      lessonProgress: lessonProgressJson.map((item) {
        final data = item as Map<String, dynamic>;

        final lesson = data['lessons'] as Map<String, dynamic>?;

        return LessonProgress(
          name: lesson?['name'] as String? ?? '',
          progress: data['progress'] as int? ?? 0,
        );
      }).toList(),

      examResults: examResultsJson.map((item) {
        final data = item as Map<String, dynamic>;

        return ExamResult(
          title: data['title'] as String? ?? '',
          score: data['score'] as int? ?? 0,
          avgPercent:
          (data['avg_percent'] as num?)?.toDouble() ?? 0,
          passRatePercent:
          (data['pass_rate_percent'] as num?)?.toDouble() ?? 0,
        );
      }).toList(),

      attendanceRecords: attendanceJson.map((item) {
        final data = item as Map<String, dynamic>;

        return StudentAttendanceRecord(
          date: DateTime.parse(
            data['date'] as String,
          ),
          status: StudentAttendanceStatus.values.firstWhere(
                (e) => e.name == data['status'],
            orElse: () => StudentAttendanceStatus.present,
          ),
        );
      }).toList(),
    );
  }
}

class LessonProgress {
  final String name;
  final int progress;

  const LessonProgress({
    required this.name,
    required this.progress,
  });

  factory LessonProgress.fromJson(Map<String, dynamic> json) {
    return LessonProgress(
      name: json['name'] as String? ?? '',
      progress: json['progress'] as int? ?? 0,
    );
  }
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

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      phone: json['phone'] as String? ?? '',
      parentPhone: json['parentPhone'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );
  }
}

class ExamResult {
  final String title;
  final int score;
  final double avgPercent;
  final double passRatePercent;

  const ExamResult({
    required this.title,
    required this.score,
    required this.avgPercent,
    required this.passRatePercent,
  });

  factory ExamResult.fromJson(Map<String, dynamic> json) {
    return ExamResult(
      title: json['title'] as String? ?? '',
      score: json['score'] as int? ?? 0,
      avgPercent: (json['avgPercent'] as num?)?.toDouble() ?? 0.0,
      passRatePercent:
      (json['passRatePercent'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

enum StudentAttendanceStatus {
  present,
  absent,
  late,
}

class StudentAttendanceRecord {
  final DateTime date;
  final StudentAttendanceStatus status;

  const StudentAttendanceRecord({
    required this.date,
    required this.status,
  });

  factory StudentAttendanceRecord.fromJson(
      Map<String, dynamic> json,
      ) {
    return StudentAttendanceRecord(
      date: DateTime.parse(
        json['date'] as String,
      ),
      status: StudentAttendanceStatus.values.firstWhere(
            (e) =>
        e.toString() ==
            'StudentAttendanceStatus.${json['status']}',
        orElse: () => StudentAttendanceStatus.present,
      ),
    );
  }
}