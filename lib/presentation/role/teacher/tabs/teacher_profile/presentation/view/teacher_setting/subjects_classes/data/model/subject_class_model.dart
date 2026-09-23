class SubjectClassModel {
  final String id;
  final String subjectName;
  final int studentsCount;
  final int activeClasses;

  SubjectClassModel({
    required this.id,
    required this.subjectName,
    required this.studentsCount,
    required this.activeClasses,
  });

  factory SubjectClassModel.fromJson(Map<String, dynamic> json) {
    return SubjectClassModel(
      id: json['id'] as String,
      subjectName: json['subject_name'] as String,
      activeClasses: (json['active_classes'] as num).toInt(),

      studentsCount: (json['students_count'] as num?)?.toInt() ?? 0,
    );
  }
}