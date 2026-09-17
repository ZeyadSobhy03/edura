class NotificationReadStats {
  final String notificationId;
  final int totalRecipients;
  final int readCount;

  NotificationReadStats({
    required this.notificationId,
    required this.totalRecipients,
    required this.readCount,
  });

  int get unreadCount => totalRecipients - readCount;

  double get readPercentage =>
      totalRecipients == 0 ? 0 : (readCount / totalRecipients) * 100;

  factory NotificationReadStats.fromJson(Map<String, dynamic> json) {
    return NotificationReadStats(
      notificationId: json['notification_id'] as String,
      totalRecipients: json['total_recipients'] as int,
      readCount: json['read_count'] as int,
    );
  }
}