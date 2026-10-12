class TeacherHomeworkSummary {
  final String id;
  final String title;
  final String subject;
  final String? lessonId;
  final String? lessonTitle;
  final DateTime? dueDate;
  final bool isPublished;
  final int pendingCount;
  final int gradedCount;

  TeacherHomeworkSummary({
    required this.id,
    required this.title,
    required this.subject,
    this.lessonId,
    this.lessonTitle,
    this.dueDate,
    required this.isPublished,
    required this.pendingCount,
    required this.gradedCount,
  });

  factory TeacherHomeworkSummary.fromJson(Map<String, dynamic> j) =>
      TeacherHomeworkSummary(
        id: j['id'].toString(),
        title: j['title'] ?? '',
        subject: j['subject'] ?? '',
        lessonId: j['lesson_id']?.toString(),
        lessonTitle: j['lesson_title'],
        dueDate: j['due_date'] != null
            ? DateTime.parse(j['due_date']).toLocal()
            : null,
        isPublished: j['is_published'] ?? false,
        pendingCount: (j['pending_count'] as num?)?.toInt() ?? 0,
        gradedCount: (j['graded_count'] as num?)?.toInt() ?? 0,
      );
}
