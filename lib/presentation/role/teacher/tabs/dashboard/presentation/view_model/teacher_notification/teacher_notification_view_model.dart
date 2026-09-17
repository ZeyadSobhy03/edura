import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/teacher_notification/notification_model.dart';
import '../../../data/model/teacher_notification/notification_read_stats.dart';
import '../../../data/model/teacher_notification/notification_recipient_model.dart';
import '../../../domain/use_case/teacher_notification/teacher_notification_use_case.dart';

@injectable
class TeacherNotificationCubit extends Cubit<TeacherNotificationState> {
  TeacherNotificationCubit(this.useCase) : super(TeacherNotificationInitial());

  final TeacherNotificationUseCase useCase;

  Future<void> createNotification({
    required String teacherId,
    required String title,
    required String message,
    required String audience,
    List<String> recipientIds = const [],
    bool isPinned = false,
  }) async {
    emit(TeacherNotificationLoading());
    try {
      final notification = await useCase.createNotification(
        teacherId: teacherId,
        title: title,
        message: message,
        audience: audience,
        recipientIds: recipientIds,
        isPinned: isPinned,
      );
      emit(TeacherNotificationCreated(notification));
      await getNotificationsByTeacher(teacherId);
    } catch (e) {
      emit(TeacherNotificationError(e.toString()));
    }
  }

  Future<void> getNotificationsByTeacher(String teacherId) async {
    emit(TeacherNotificationLoading());
    try {
      final notifications = await useCase.getNotificationsByTeacher(teacherId);
      emit(TeacherNotificationLoaded(notifications));
    } catch (e) {
      emit(TeacherNotificationError(e.toString()));
    }
  }

  Future<void> deleteNotification(
    String notificationId, {
    required String teacherId,
  }) async {
    emit(TeacherNotificationLoading());
    try {
      await useCase.deleteNotification(notificationId);
      await getNotificationsByTeacher(teacherId);
    } catch (e) {
      emit(TeacherNotificationError(e.toString()));
    }
  }

  Future<void> setPinned(
    String notificationId,
    bool isPinned, {
    required String teacherId,
  }) async {
    try {
      await useCase.setPinned(notificationId, isPinned);
      await getNotificationsByTeacher(teacherId);
    } catch (e) {
      emit(TeacherNotificationError(e.toString()));
    }
  }

  Future<void> getRecipients(String notificationId) async {
    emit(TeacherNotificationLoading());
    try {
      final recipients = await useCase.getRecipients(notificationId);
      emit(TeacherNotificationRecipientsLoaded(recipients));
    } catch (e) {
      emit(TeacherNotificationError(e.toString()));
    }
  }

  Future<void> getReadStats(String notificationId) async {
    emit(TeacherNotificationLoading());
    try {
      final stats = await useCase.getReadStats(notificationId);
      emit(TeacherNotificationReadStatsLoaded(stats));
    } catch (e) {
      emit(TeacherNotificationError(e.toString()));
    }
  }
}

sealed class TeacherNotificationState {}

class TeacherNotificationInitial extends TeacherNotificationState {}

class TeacherNotificationLoading extends TeacherNotificationState {}

class TeacherNotificationError extends TeacherNotificationState {
  final String message;

  TeacherNotificationError(this.message);
}

class TeacherNotificationLoaded extends TeacherNotificationState {
  final List<NotificationModel> notifications;

  TeacherNotificationLoaded(this.notifications);
}

class TeacherNotificationCreated extends TeacherNotificationState {
  final NotificationModel notification;

  TeacherNotificationCreated(this.notification);
}

class TeacherNotificationRecipientsLoaded extends TeacherNotificationState {
  final List<NotificationRecipientModel> recipients;

  TeacherNotificationRecipientsLoaded(this.recipients);
}

class TeacherNotificationReadStatsLoaded extends TeacherNotificationState {
  final NotificationReadStats stats;

  TeacherNotificationReadStatsLoaded(this.stats);
}
