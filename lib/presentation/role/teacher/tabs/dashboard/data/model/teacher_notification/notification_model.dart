enum NotificationCategory {
  lesson,
  exam,
  assignment,
  grade,
  announcement,
  payment,
  general;

  static NotificationCategory fromString(String value) {
    return NotificationCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NotificationCategory.general,
    );
  }
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String time;
  bool isRead;
  final NotificationCategory category;
  final bool isPinned;
  final String audience;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
    required this.category,
    this.isPinned = false,
    this.audience = 'all_students',
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      time: json['created_at'] as String? ?? json['time'] as String? ?? '',
      isRead: json['is_read'] as bool? ?? json['isRead'] as bool? ?? false,
      category: NotificationCategory.fromString(
        json['category'] as String? ?? 'general',
      ),
      isPinned: json['is_pinned'] as bool? ?? false,
      audience: json['audience'] as String? ?? 'all_students',
    );
  }
}
