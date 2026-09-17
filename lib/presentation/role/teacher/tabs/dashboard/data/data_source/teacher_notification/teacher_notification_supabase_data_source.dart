import 'package:edura/presentation/role/teacher/tabs/dashboard/data/data_source/teacher_notification/teacher_notification_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/teacher_notification/notification_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/teacher_notification/notification_read_stats.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/teacher_notification/notification_recipient_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: TeacherNotificationRemoteDataSource)
class TeacherNotificationSupabaseDataSource
    implements TeacherNotificationRemoteDataSource {
  final supabase = Supabase.instance.client;
  static const _notificationsTable = 'notifications';
  static const _recipientsTable = 'notification_recipients';

  @override
  Future<NotificationModel> createNotification({
    required String teacherId,
    required String title,
    required String message,
    required String audience,
    List<String> recipientIds = const [],
    bool isPinned = false,
  }) async {
    final response = await supabase
        .from(_notificationsTable)
        .insert({
          'teacher_id': teacherId,
          'title': title,
          'message': message,
          'audience': audience,
          'is_pinned': isPinned,
        })
        .select()
        .single();

    final notification = NotificationModel.fromJson(response);

    if (audience == 'individual' && recipientIds.isNotEmpty) {
      await supabase
          .from(_recipientsTable)
          .insert(
            recipientIds
                .map(
                  (studentId) => {
                    'notification_id': notification.id,
                    'student_id': studentId,
                  },
                )
                .toList(),
          );
    }

    return notification;
  }

  @override
  Future<List<NotificationModel>> getNotificationsByTeacher(
    String teacherId,
  ) async {
    final response = await supabase
        .from(_notificationsTable)
        .select()
        .eq('teacher_id', teacherId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => NotificationModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    await supabase.from(_notificationsTable).delete().eq('id', notificationId);
  }

  @override
  Future<void> setPinned(String notificationId, bool isPinned) async {
    await supabase
        .from(_notificationsTable)
        .update({'is_pinned': isPinned})
        .eq('id', notificationId);
  }

  @override
  Future<List<NotificationRecipientModel>> getRecipients(
    String notificationId,
  ) async {
    final response = await supabase
        .from(_recipientsTable)
        .select()
        .eq('notification_id', notificationId);

    return (response as List)
        .map(
          (json) =>
              NotificationRecipientModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<NotificationReadStats> getReadStats(String notificationId) async {
    final response = await supabase
        .from(_recipientsTable)
        .select('is_read')
        .eq('notification_id', notificationId);

    final rows = response as List;
    final total = rows.length;
    final readCount = rows
        .where((r) => (r as Map<String, dynamic>)['is_read'] == true)
        .length;

    return NotificationReadStats(
      notificationId: notificationId,
      totalRecipients: total,
      readCount: readCount,
    );
  }
}
