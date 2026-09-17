import '../../model/teacher_notification/notification_model.dart';
import '../../model/teacher_notification/notification_read_stats.dart';
import '../../model/teacher_notification/notification_recipient_model.dart';

abstract class TeacherNotificationRemoteDataSource {
  Future<NotificationModel> createNotification({
    required String teacherId,
    required String title,
    required String message,
    required String audience,
    List<String> recipientIds = const [],
    bool isPinned = false,
  });

  Future<List<NotificationModel>> getNotificationsByTeacher(String teacherId);

  Future<void> deleteNotification(String notificationId);

  Future<void> setPinned(String notificationId, bool isPinned);

  Future<List<NotificationRecipientModel>> getRecipients(String notificationId);

  Future<NotificationReadStats> getReadStats(String notificationId);
}
