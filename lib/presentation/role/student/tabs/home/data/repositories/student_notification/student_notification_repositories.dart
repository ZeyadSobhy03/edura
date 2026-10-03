import '../../../../../../teacher/tabs/dashboard/data/model/teacher_notification/notification_model.dart';

abstract class StudentNotificationRepositories {
  Future<List<NotificationModel>> getNotificationsOfStudent(
      String studentId,
      );
  Future<void> markAsRead({
    required String notificationId,
    required String studentId,
  });
  Future<void> deleteNotificationOfStudent(
      String notificationId,
      String studentId,
      );
}