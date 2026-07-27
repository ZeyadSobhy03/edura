class AnnouncementModel {

  final String title;
  final String id;
  final String description;
  final DateTime date;
  final bool isPinned;
  final String author;
  AnnouncementModel({
    required this.title,
    required this.description,
    required this.date,
    required this.isPinned,
    required this.author, required this.id,
  });




}


class DummyAnnouncementData {
  static List<AnnouncementModel> all = [
    AnnouncementModel(
      id: '1',
      title: 'Midterm Exam Schedule Released',
      description:
      'The midterm exam schedule for all subjects has been published. Please check your dashboard for exact dates and times.',
      date: DateTime(2026, 7, 20),
      isPinned: true,
      author: 'Admin Office',
    ),
    AnnouncementModel(
      id: '2',
      title: 'Platform Maintenance Notice',
      description:
      'The platform will undergo scheduled maintenance this weekend from 2 AM to 5 AM. Some features may be temporarily unavailable.',
      date: DateTime(2026, 7, 18),
      isPinned: true,
      author: 'Tech Support',
    ),
    AnnouncementModel(
      id: '3',
      title: 'New Physics Course Available',
      description:
      'A new advanced physics course covering electromagnetism has just been added to the curriculum.',
      date: DateTime(2026, 7, 15),
      isPinned: false,
      author: 'Dr. Sarah Mitchell',
    ),
    AnnouncementModel(
      id: '4',
      title: 'Holiday Schedule Update',
      description:
      'Please note the updated holiday schedule for the upcoming semester break.',
      date: DateTime(2026, 7, 10),
      isPinned: false,
      author: 'Admin Office',
    ),
    AnnouncementModel(
      id: '5',
      title: 'Library Resources Expanded',
      description:
      'We\'ve added over 500 new digital textbooks and reference materials to the online library.',
      date: DateTime(2026, 7, 5),
      isPinned: false,
      author: 'Library Team',
    ),
  ];
}