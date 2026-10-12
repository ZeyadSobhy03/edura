enum SubmissionStatus { pending, graded }

class HomeworkSubmissionModel {
  final String id;
  final String studentName;
  final String lessonTitle;
  final DateTime submittedAt;
  final String fileName;
  final String fileUrl;
  final int? existingGrade;
  final String? existingFeedback;
  final SubmissionStatus status;
  final int? grade;
  final String? feedback;
  final String? lessonId;


  HomeworkSubmissionModel({
    required this.id,
    required this.studentName,
    required this.lessonTitle,
    required this.submittedAt,
    required this.fileName,
    required this.fileUrl,
    this.existingGrade,
    this.existingFeedback, required this.status, this.grade, this.feedback, this.lessonId,
  });

  factory HomeworkSubmissionModel.fromJson(Map<String, dynamic> json) {
    final grade = json['existing_grade'] ?? json['grade'];
    final feedback = json['existing_feedback'] ?? json['feedback'];

    return HomeworkSubmissionModel(
      feedback: feedback,
      grade: grade,
      status: grade != null ? SubmissionStatus.graded : SubmissionStatus.pending,
      id: json['id'].toString(),
      studentName: json['student_name'] ?? '',
      lessonTitle: json['lesson_title'] ?? '',
      submittedAt: DateTime.parse(
        json['submitted_at'] ?? DateTime.now().toIso8601String(),
      ).toLocal(),
      fileName: json['file_name'] ?? '',
      fileUrl: json['file_url'] ?? '',
      existingGrade: grade,
      existingFeedback: feedback,
    );
  }
}

