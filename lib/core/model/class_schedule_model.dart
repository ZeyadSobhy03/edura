enum ClassType { lecture, lab, exam }

class ClassScheduleModel {
  final String id;
  final String title;
  final String subject;
  final ClassType type;
  final DateTime date;
  final String time;
  final String room;

  ClassScheduleModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.type,
    required this.date,
    required this.time,
    required this.room,
  });

  factory ClassScheduleModel.fromJson(Map<String, dynamic> json) {
    return ClassScheduleModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      subject: json['subject'] ?? '',
      type: ClassType.values.firstWhere(
            (e) => e.name == json['type'],
        orElse: () => ClassType.lecture,
      ),
      date: DateTime.parse(json['date']),
      time: json['time'] ?? '',
      room: json['room'] ?? '',
    );
  }
}

class DummyScheduleData {
  static List<ClassScheduleModel> all = [
    ClassScheduleModel(
      id: '1',
      title: 'Derivatives Review',
      subject: 'Mathematics',
      type: ClassType.lecture,
      date: DateTime(2026, 1, 17),
      time: '10:00 AM',
      room: 'Room 204',
    ),
    ClassScheduleModel(
      id: '2',
      title: 'EM Waves Lab',
      subject: 'Physics',
      type: ClassType.lab,
      date: DateTime(2026, 1, 17),
      time: '2:00 PM',
      room: 'Lab 3',
    ),
    ClassScheduleModel(
      id: '3',
      title: 'Calculus Midterm',
      subject: 'Mathematics',
      type: ClassType.exam,
      date: DateTime(2026, 1, 17),
      time: '5:00 PM',
      room: 'Room 204',
    ),
    ClassScheduleModel(
      id: '4',
      title: 'Integration Techniques',
      subject: 'Mathematics',
      type: ClassType.lecture,
      date: DateTime(2026, 1, 18),
      time: '9:00 AM',
      room: 'Room 101',
    ),
  ];
}