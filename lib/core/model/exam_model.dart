
enum ExamStatus { available, completed, upcoming, locked }

class ExamModel {
  final String id;
  final String title;
  final String subject;
  final ExamStatus status;
  final int durationMinutes;
  final int questionsCount;
  final DateTime date;
  final double? score;
  final bool? passed;
  final List<String>? instructions;
  final List<String>? requirements;

  ExamModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.status,
    required this.durationMinutes,
    required this.questionsCount,
    required this.date,
    this.score,
    this.passed,
    this.instructions,
    this.requirements,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      subject: json['subject'] ?? '',
      status: ExamStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => ExamStatus.upcoming,
      ),
      durationMinutes: json['duration_minutes'] ?? 0,
      questionsCount: json['questions_count'] ?? 0,
      date: DateTime.parse(json['date']),
      score: json['score'] != null ? (json['score'] as num).toDouble() : null,
      passed: json['passed'],
    );
  }


}

class DummyExamData {
  static List<ExamModel> all = [
    ExamModel(
      id: '1',
      title: 'Calculus Midterm',
      subject: 'Mathematics',
      status: ExamStatus.available,
      durationMinutes: 90,
      questionsCount: 30,
      date: DateTime(2026, 1, 20),
    ),
    ExamModel(
      id: '2',
      title: 'Physics Quiz 1',
      subject: 'Physics',
      status: ExamStatus.completed,
      durationMinutes: 45,
      questionsCount: 20,
      date: DateTime(2026, 1, 10),
      score: 88,
      passed: true,
    ),
    ExamModel(
      id: '3',
      title: 'Chemistry Final',
      subject: 'Chemistry',
      status: ExamStatus.completed,
      durationMinutes: 120,
      questionsCount: 50,
      date: DateTime(2025, 12, 15),
      score: 42,
      passed: false,
    ),
    ExamModel(
      id: '4',
      title: 'Integration Techniques Test',
      subject: 'Mathematics',
      status: ExamStatus.upcoming,
      durationMinutes: 60,
      questionsCount: 25,
      date: DateTime(2026, 2, 5),
    ),
    ExamModel(
      id: '5',
      title: 'Advanced Mechanics',
      subject: 'Physics',
      status: ExamStatus.locked,
      durationMinutes: 90,
      questionsCount: 35,
      date: DateTime(2026, 2, 20),
    ),
  ];
}