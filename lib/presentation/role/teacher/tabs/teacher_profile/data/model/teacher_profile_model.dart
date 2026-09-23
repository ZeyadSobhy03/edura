class TeacherProfileModel {
  final String name;
  final String subject;
  final String? bio;
  final String? phone;

  final int studentsCount;
  final double rating;
  final int yearsExperience;
  final int homeworkCount;
  final int lessonsCount;
  final int examsCount;

  TeacherProfileModel({
    required this.name,
    required this.subject,
    required this.studentsCount,
    required this.rating,
    required this.yearsExperience,
    required this.homeworkCount,
    required this.lessonsCount,
    required this.examsCount, this.bio, this.phone,
  });

  factory TeacherProfileModel.fromJson(Map<String, dynamic> json) {
    return TeacherProfileModel(
      name: json['name'] as String,
      subject: json['subject'] as String,
      studentsCount: json['students_count'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      yearsExperience: json['years_experience'] as int? ?? 0,
      homeworkCount: json['homeworks_count'] as int? ?? 0,
      lessonsCount: json['lessons_count'] as int? ?? 0,
      examsCount: json['exams_count'] as int? ?? 0,
      bio: json['bio'] as String?,
      phone: json['phone'] as String?,
    );
  }
}