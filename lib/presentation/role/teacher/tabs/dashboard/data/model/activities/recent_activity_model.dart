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

  factory RecentActivityModel.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    final name = json['name'] as String? ?? '';
    final status = json['status'] as String? ?? '';
    final createdAt = DateTime.parse(json['created_at'] as String);

    late final String title;
    late final String description;
    late final IconData icon;

    switch (type) {
      case 'attendance':
        title = 'Attendance Update';
        description = status == 'present'
            ? '$name was marked present'
            : '$name was marked absent';
        icon = CupertinoIcons.person_crop_circle_fill;
        break;
      case 'payment':
        title = 'Payment Update';
        description = status == 'completed'
            ? 'Payment received from $name'
            : 'Payment pending for $name';
        icon = CupertinoIcons.money_dollar_circle;
        break;
      case 'lesson':
        title = 'Lesson Update';
        description = status == 'published'
            ? '"$name" was published'
            : '"$name" saved as draft';
        icon = CupertinoIcons.doc_text;
        break;
      case 'exam':
        title = 'New Exam';
        description = '"$name" was created';
        icon = CupertinoIcons.check_mark_circled;
        break;
      default:
        title = 'Activity';
        description = name;
        icon = CupertinoIcons.bell;
    }

    return RecentActivityModel(
      id: '$type-${createdAt.microsecondsSinceEpoch}',
      title: title,
      description: description,
      timestamp: createdAt,
      icon: icon,
    );
  }
}