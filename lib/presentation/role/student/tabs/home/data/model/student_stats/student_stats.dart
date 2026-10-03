class StudentStatsModel {
  final int lessons;
  final int completedLessons;
  final int studyMinutes;
  final int averageScore;

  const StudentStatsModel({
    required this.lessons,
    required this.completedLessons,
    required this.studyMinutes,
    required this.averageScore,
  });

  factory StudentStatsModel.fromJson(Map<String, dynamic> json) =>
      StudentStatsModel(
        lessons: json['lessons'] ?? 0,
        completedLessons: json['completed_lessons'] ?? 0,
        studyMinutes: json['study_minutes'] ?? 0,
        averageScore: json['average_score'] ?? 0,
      );
}