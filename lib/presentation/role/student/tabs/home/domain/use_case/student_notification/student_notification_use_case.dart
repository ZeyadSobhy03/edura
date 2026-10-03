import 'package:edura/presentation/role/student/tabs/home/data/repositories/student_notification/student_notification_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../teacher/tabs/dashboard/data/model/teacher_notification/notification_model.dart';

@injectable
class StudentNotificationUseCase {
  final StudentNotificationRepositories studentNotificationRepositories;

  StudentNotificationUseCase({required this.studentNotificationRepositories});

  Future<List<NotificationModel>> getNotificationsOfStudent(String studentId) {
    return studentNotificationRepositories.getNotificationsOfStudent(studentId);
  }

  Future<void> markAsRead({
    required String notificationId,
    required String studentId,
  }) {
    return studentNotificationRepositories.markAsRead(
      notificationId: notificationId,
      studentId: studentId,
    );
  }

  Future<void> deleteNotificationOfStudent(
    String notificationId,
    String studentId,
  ) {
    return studentNotificationRepositories.deleteNotificationOfStudent(
      notificationId,
      studentId,
    );
  }
}
