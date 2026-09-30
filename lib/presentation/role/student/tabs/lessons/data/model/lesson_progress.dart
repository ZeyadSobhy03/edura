class LessonProgressModel {
  final String lessonId;
  final String studentId;
  final int progress;

  LessonProgressModel({
    required this.lessonId,
    required this.studentId,
    required this.progress,
  });

  LessonProgressModel copyWith({
    String? lessonId,
    String? studentId,
    int? progress,
  }) {
    return LessonProgressModel(
      lessonId: lessonId ?? this.lessonId,
      studentId: studentId ?? this.studentId,
      progress: progress ?? this.progress,
    );
  }

  factory LessonProgressModel.fromJson(Map<String, dynamic> json) {
    return LessonProgressModel(
      lessonId: json['lesson_id'] ?? '',
      studentId: json['student_id'] ?? '',
      progress: json['progress'] ?? 0,
    );
  }
}