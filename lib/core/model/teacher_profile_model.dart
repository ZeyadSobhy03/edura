class TeacherProfileModel {
  final String name;
  final String subject;
  final String? avatarUrl;
  final int studentsCount;
  final double rating;
  final int yearsExperience;

  TeacherProfileModel({
    required this.name,
    required this.subject,
    this.avatarUrl,
    required this.studentsCount,
    required this.rating,
    required this.yearsExperience,
  });
}