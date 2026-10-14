class ExamSummaryModel {
  final int id;
  final String title, subject, grade;
  final int submitted, inProgress;
  final double? avgPercent;

  ExamSummaryModel.fromJson(Map<String, dynamic> j)
    : id = (j['id'] as num).toInt(),
      title = j['title'] ?? '',
      subject = j['subject'] ?? '',
      grade = j['grade'] ?? '',
      submitted = (j['submitted_count'] as num?)?.toInt() ?? 0,
      inProgress = (j['in_progress_count'] as num?)?.toInt() ?? 0,
      avgPercent = (j['avg_percent'] as num?)?.toDouble();
}

class StudentResultModel {
  final String studentId, name, status;
  final double score, maxScore, percent;
  final DateTime? submittedAt;

  StudentResultModel.fromJson(Map<String, dynamic> j)
    : studentId = j['student_id'].toString(),
      name = j['student_name'] ?? '',
      status = j['status'] ?? '',
      score = (j['score'] as num?)?.toDouble() ?? 0,
      maxScore = (j['max_score'] as num?)?.toDouble() ?? 0,
      percent = (j['percent'] as num?)?.toDouble() ?? 0,
      submittedAt = j['submitted_at'] != null
          ? DateTime.parse(j['submitted_at']).toLocal()
          : null;

  bool get isSubmitted => status == 'submitted';

  bool get passed => percent >= 60;
}
