enum HomeworkStatus { pending, submitted, graded }

class HomeworkModel {
  final String id;
  final String title;
  final String subject;
  final HomeworkStatus status;
  final DateTime dueDate;

  HomeworkModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.status,
    required this.dueDate,
  });

  factory HomeworkModel.fromJson(Map<String, dynamic> json) {
    return HomeworkModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      subject: json['subject'] ?? '',
      status: HomeworkStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => HomeworkStatus.pending,
      ),
      dueDate: DateTime.parse(json['due_date']),
    );
  }
}
class DummyHomeworkData {
  static HomeworkModel calculusDerivatives = HomeworkModel(
    id: '1',
    title: 'Calculus Derivatives',
    subject: 'Mathematics',
    status: HomeworkStatus.pending,
    dueDate: DateTime(2024, 1, 19),
  );

  static HomeworkModel physicsLab = HomeworkModel(
    id: '2',
    title: 'Physics Lab Report',
    subject: 'Physics',
    status: HomeworkStatus.submitted,
    dueDate: DateTime(2024, 1, 22),
  );

  static HomeworkModel chemistryQuiz = HomeworkModel(
    id: '3',
    title: 'Chemical Reactions Quiz',
    subject: 'Chemistry',
    status: HomeworkStatus.graded,
    dueDate: DateTime(2024, 1, 15),
  );

  static List<HomeworkModel> all = [
    calculusDerivatives,
    physicsLab,
    chemistryQuiz,
  ];
}
