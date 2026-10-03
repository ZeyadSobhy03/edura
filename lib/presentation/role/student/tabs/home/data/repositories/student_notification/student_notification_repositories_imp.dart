import 'package:edura/presentation/role/student/tabs/home/data/data_source/student_notification/student_notification_remote_data_source.dart';
import 'package:edura/presentation/role/student/tabs/home/data/repositories/student_notification/student_notification_repositories.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/teacher_notification/notification_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: StudentNotificationRepositories)
class StudentNotificationRepositoriesImp
    implements StudentNotificationRepositories {
  final StudentNotificationRemoteDataSource studentNotificationRemoteDataSource;

  StudentNotificationRepositoriesImp({
    required this.studentNotificationRemoteDataSource,
  });

  @override
  Future<void> deleteNotificationOfStudent(
    String notificationId,
    String studentId,
  ) {
    return studentNotificationRemoteDataSource.deleteNotificationOfStudent(
      notificationId,
      studentId,
    );
  }

  @override
  Future<List<NotificationModel>> getNotificationsOfStudent(String studentId) {
    return studentNotificationRemoteDataSource.getNotificationsOfStudent(
      studentId,
    );
  }

  @override
  Future<void> markAsRead({
    required String notificationId,
    required String studentId,
  }) {
    return studentNotificationRemoteDataSource.markAsRead(
      notificationId: notificationId,
      studentId: studentId,
    );
  }
}
