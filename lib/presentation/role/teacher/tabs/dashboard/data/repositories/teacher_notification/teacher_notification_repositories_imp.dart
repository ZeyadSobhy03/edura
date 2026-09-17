import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/teacher_notification/notification_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/teacher_notification/notification_read_stats.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/teacher_notification/notification_recipient_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/repositories/teacher_notification/teacher_notification_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/teacher_notification/teacher_notification_remote_data_source.dart';

@LazySingleton(as: TeacherNotificationRepositories)
class TeacherNotificationRepositoriesImp
    implements TeacherNotificationRepositories {
  final TeacherNotificationRemoteDataSource remoteDataSource;

  TeacherNotificationRepositoriesImp({required this.remoteDataSource});

  @override
  Future<NotificationModel> createNotification({
    required String teacherId,
    required String title,
    required String message,
    required String audience,
    List<String> recipientIds = const [],
    bool isPinned = false,
  }) {
    return remoteDataSource.createNotification(
      teacherId: teacherId,
      title: title,
      message: message,
      audience: audience,
      recipientIds: recipientIds,
      isPinned: isPinned,
    );
  }

  @override
  Future<void> deleteNotification(String notificationId) {
    return remoteDataSource.deleteNotification(notificationId);
  }

  @override
  Future<List<NotificationModel>> getNotificationsByTeacher(String teacherId) {
    return remoteDataSource.getNotificationsByTeacher(teacherId);
  }

  @override
  Future<NotificationReadStats> getReadStats(String notificationId) {
    return remoteDataSource.getReadStats(notificationId);
  }

  @override
  Future<List<NotificationRecipientModel>> getRecipients(
    String notificationId,
  ) {
    return remoteDataSource.getRecipients(notificationId);
  }

  @override
  Future<void> setPinned(String notificationId, bool isPinned) {
    return remoteDataSource.setPinned(notificationId, isPinned);
  }
}
