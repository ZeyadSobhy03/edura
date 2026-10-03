import 'package:injectable/injectable.dart';

import '../../../data/model/teacher_notification/notification_model.dart';
import '../../../data/model/teacher_notification/notification_read_stats.dart';
import '../../../data/model/teacher_notification/notification_recipient_model.dart';
import '../../../data/repositories/teacher_notification/teacher_notification_repositories.dart';

@injectable
class TeacherNotificationUseCase {
  final TeacherNotificationRepositories teacherNotificationRepositories;

  TeacherNotificationUseCase({required this.teacherNotificationRepositories});

  Future<NotificationModel> createNotification({
    required String teacherId,
    required String title,
    required String message,
    required String audience,
    required String teacherName,

    List<String> recipientIds = const [],
    bool isPinned = false,
  }) {
    return teacherNotificationRepositories.createNotification(
      teacherId: teacherId,
      teacherName: teacherName,
      title: title,
      message: message,
      audience: audience,
      recipientIds: recipientIds,
      isPinned: isPinned,
    );
  }

  Future<List<NotificationModel>> getNotificationsByTeacher(String teacherId) {
    return teacherNotificationRepositories.getNotificationsByTeacher(teacherId);
  }

  Future<void> deleteNotification(String notificationId, String teacherId) {
    return teacherNotificationRepositories.deleteNotification(
      notificationId,
      teacherId,
    );
  }

  Future<void> setPinned(String notificationId, bool isPinned) {
    return teacherNotificationRepositories.setPinned(notificationId, isPinned);
  }

  Future<List<NotificationRecipientModel>> getRecipients(
    String notificationId,
  ) {
    return teacherNotificationRepositories.getRecipients(notificationId);
  }

  Future<NotificationReadStats> getReadStats(String notificationId) {
    return teacherNotificationRepositories.getReadStats(notificationId);
  }
}
