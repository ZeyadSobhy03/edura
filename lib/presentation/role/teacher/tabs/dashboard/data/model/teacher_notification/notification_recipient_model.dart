class NotificationRecipientModel {
  final String id;
  final String notificationId;
  final String studentId;
  bool isRead;
  final DateTime? readAt;

  NotificationRecipientModel({
    required this.id,
    required this.notificationId,
    required this.studentId,
    this.isRead = false,
    this.readAt,
  });

  factory NotificationRecipientModel.fromJson(Map<String, dynamic> json) {
    return NotificationRecipientModel(
      id: json['id'] as String,
      notificationId: json['notification_id'] as String,
      studentId: json['student_id'] as String,
      isRead: json['is_read'] as bool? ?? false,
      readAt: json['read_at'] != null
          ? DateTime.parse(json['read_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'notification_id': notificationId,
      'student_id': studentId,
      'is_read': isRead,
      'read_at': readAt?.toIso8601String(),
    };
  }
}