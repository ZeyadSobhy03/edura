import 'package:flutter/cupertino.dart';

class RecentActivityModel {
  final String id;
  final String title;
  final String description;
  final DateTime timestamp;
  final IconData icon;

  RecentActivityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.icon,
  });
}
class DummyActivityModel {
  static List<RecentActivityModel> getDummyActivities() {
    return [
      RecentActivityModel(
        id: '1',
        title: 'New Assignment',
        description: 'You have a new assignment in Math.',
        timestamp: DateTime.now().subtract(Duration(minutes: 5)),
        icon: CupertinoIcons.doc_text,
      ),
      RecentActivityModel(
        id: '2',
        title: 'Grade Posted',
        description: 'Your grade for Science has been posted.',
        timestamp: DateTime.now().subtract(Duration(hours: 1)),
        icon: CupertinoIcons.check_mark_circled,
      ),
      RecentActivityModel(
        id: '3',
        title: 'Attendance Update',
        description: 'You were marked present for today\'s class.',
        timestamp: DateTime.now().subtract(Duration(days: 1)),
        icon: CupertinoIcons.person_crop_circle_fill,
      ),
    ];
  }
}
