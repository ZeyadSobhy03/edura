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

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
    required this.category,
  });



}
