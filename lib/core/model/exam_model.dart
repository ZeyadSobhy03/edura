enum ExamStatus { available, completed, upcoming, locked }

class ExamModel {
  final String id;
  final String title;
  final String subject;
  final ExamStatus status;
  final int durationMinutes;
  final int questionsCount;
  final DateTime date;
  final DateTime? startDate;
  final DateTime? endDate;
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
    this.startDate,
    this.endDate,
    this.score,
    this.passed,
    this.instructions,
    this.requirements,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    DateTime? parse(dynamic v) =>
        v == null ? null : DateTime.parse(v as String).toLocal();

    final startDate = parse(json['start_date']);
    final endDate = parse(json['end_date']);
    final createdAt = parse(json['created_at']) ?? DateTime.now();

    final attemptState = json['attempt_state'] as String?;
    final isLocked = json['is_locked'] as bool? ?? false;

    double? percent;
    bool? passed;
    if (attemptState == 'submitted' &&
        json['score'] != null &&
        json['max_score'] != null) {
      final max = (json['max_score'] as num).toDouble();
      if (max > 0) {
        percent = (json['score'] as num).toDouble() / max * 100;
        passed = percent >= 50;
      }
    }

    return ExamModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      subject: json['subject'] ?? '',
      status: _computeStatus(
        isLocked: isLocked,
        attemptState: attemptState,
        startDate: startDate,
        endDate: endDate,
      ),
      durationMinutes: json['duration_minutes'] ?? 0,
      questionsCount:  json['question_count'] ?? 0,
      date: startDate ?? endDate ?? createdAt,
      startDate: startDate,
      endDate: endDate,
      score: percent,
      passed: passed,
      instructions: null,
      requirements: null,
    );
  }

  static ExamStatus _computeStatus({
    required bool isLocked,
    required String? attemptState,
    required DateTime? startDate,
    required DateTime? endDate,
  }) {
    final now = DateTime.now();
    if (attemptState == 'submitted') return ExamStatus.completed;
    if (isLocked) return ExamStatus.locked;
    if (attemptState == 'in_progress') return ExamStatus.locked; // no resume yet
    if (startDate != null && now.isBefore(startDate)) return ExamStatus.upcoming;
    if (endDate != null && now.isAfter(endDate)) return ExamStatus.locked;
    return ExamStatus.available;
  }
}