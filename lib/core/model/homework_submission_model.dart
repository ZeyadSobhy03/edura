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
  final int? grade; // out of 100, null until graded
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
    return HomeworkSubmissionModel(
      feedback: json['existing_feedback'],
      grade: json['existing_grade'],
      status: json['existing_grade'] != null ? SubmissionStatus.graded : SubmissionStatus.pending,
      id: json['id'].toString(),
      studentName: json['student_name'] ?? '',
      lessonTitle: json['lesson_title'] ?? '',
      submittedAt: DateTime.parse(
        json['submitted_at'] ?? DateTime.now().toIso8601String(),
      ),
      fileName: json['file_name'] ?? '',
      fileUrl: json['file_url'] ?? '',
      existingGrade: json['existing_grade'],
      existingFeedback: json['existing_feedback'],
    );
  }
}

class DummySubmissionData {
  static List<HomeworkSubmissionModel> all = [
    HomeworkSubmissionModel(
      id: 's1',
      lessonId: '2', // Calculus Derivatives
      studentName: 'Alex Johnson',
      lessonTitle: 'Calculus Derivatives',
      submittedAt: DateTime.now().subtract(const Duration(hours: 2)),
      fileName: 'homework-submission.pdf',
      fileUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      status: SubmissionStatus.pending,
    ),
    HomeworkSubmissionModel(
      id: 's2',
      lessonId: '1', // Quantum Mechanics
      studentName: 'Emma Davis',
      lessonTitle: 'Quantum Mechanics',
      submittedAt: DateTime.now().subtract(const Duration(hours: 5)),
      fileName: 'homework-submission.pdf',
      fileUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      status: SubmissionStatus.pending,
    ),
    HomeworkSubmissionModel(
      id: 's3',
      lessonId: '2',
      studentName: 'Sofia Martinez',
      lessonTitle: 'Calculus Derivatives',
      submittedAt: DateTime.now().subtract(const Duration(days: 1)),
      fileName: 'homework-submission.pdf',
      fileUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      status: SubmissionStatus.graded,
      grade: 92,
    ),
    HomeworkSubmissionModel(
      id: 's4',
      lessonId: '1',
      studentName: 'Zara Ahmed',
      lessonTitle: 'Integration Techniques',
      submittedAt: DateTime.now().subtract(const Duration(days: 2)),
      fileName: 'homework-submission.pdf',
      fileUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      status: SubmissionStatus.graded,
      grade: 88,
    ),
  ];
}
