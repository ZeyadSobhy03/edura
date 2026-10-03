import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/teacher_notification/notification_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_case/student_notification/student_notification_use_case.dart';

@injectable
class StudentNotificationCubit extends Cubit<StudentNotificationState> {
  final StudentNotificationUseCase studentNotificationUseCase;

  StudentNotificationCubit({required this.studentNotificationUseCase})
    : super(StudentNotificationInitial());

  Future<void> getNotificationsOfStudent(String studentId) async {
    emit(StudentNotificationLoading());
    try {
      final notifications = await studentNotificationUseCase
          .getNotificationsOfStudent(studentId);
      emit(StudentNotificationLoaded(notifications));
    } catch (e) {
      emit(StudentNotificationError(e.toString()));
    }
  }

  Future<void> markAsRead(String notificationId, String studentId) async {
    emit(StudentNotificationLoading());
    try {
      await studentNotificationUseCase.markAsRead(
        notificationId: notificationId,
        studentId: studentId,
      );
      await getNotificationsOfStudent(studentId);
    } catch (e) {
      emit(StudentNotificationError(e.toString()));
    }
  }

  Future<void> deleteNotificationOfStudent(
    String notificationId,
    String studentId,
  ) async {
    emit(StudentNotificationLoading());
    try {
      await studentNotificationUseCase.deleteNotificationOfStudent(
        notificationId,
        studentId,
      );
      await getNotificationsOfStudent(studentId);
    } catch (e) {
      emit(StudentNotificationError(e.toString()));
    }
  }
}

sealed class StudentNotificationState {}

class StudentNotificationInitial extends StudentNotificationState {}

class StudentNotificationLoading extends StudentNotificationState {}

class StudentNotificationLoaded extends StudentNotificationState {
  final List<NotificationModel> notifications;

  StudentNotificationLoaded(this.notifications);
}

class StudentNotificationError extends StudentNotificationState {
  final String message;

  StudentNotificationError(this.message);
}
