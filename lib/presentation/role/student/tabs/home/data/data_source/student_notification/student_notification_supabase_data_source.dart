import 'package:edura/presentation/role/student/tabs/home/data/data_source/student_notification/student_notification_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../teacher/tabs/dashboard/data/model/teacher_notification/notification_model.dart';

@LazySingleton(as: StudentNotificationRemoteDataSource)
class StudentNotificationSupabaseDataSource
    implements StudentNotificationRemoteDataSource {
  final supabase = Supabase.instance.client;
  static const _notificationsTable = 'notifications';
  static const _recipientsTable = 'notification_recipients';
  static const _stateTable = 'notification_student_state';

  @override
  Future<List<NotificationModel>> getNotificationsOfStudent(
    String studentId,
  ) async {
    final individualRows = await supabase
        .from(_recipientsTable)
        .select('notification_id')
        .eq('student_id', studentId);

    final individualIds = (individualRows as List)
        .map((j) => (j as Map<String, dynamic>)['notification_id'] as String)
        .toSet();

    final orParts = <String>['audience.eq.all_students'];
    if (individualIds.isNotEmpty) {
      orParts.add('id.in.(${individualIds.join(',')})');
    }

    final response = await supabase
        .from(_notificationsTable)
        .select()
        .or(orParts.join(','))
        .order('created_at', ascending: false);

    final notifications = (response as List)
        .map((json) => NotificationModel.fromJson(json as Map<String, dynamic>))
        .toList();

    if (notifications.isEmpty) return notifications;

    final stateRows = await supabase
        .from(_stateTable)
        .select('notification_id, is_read, is_deleted')
        .eq('student_id', studentId);

    final readMap = <String, bool>{};
    final deletedIds = <String>{};

    for (final r in (stateRows as List)) {
      final row = r as Map<String, dynamic>;
      final id = row['notification_id'] as String;
      readMap[id] = row['is_read'] as bool? ?? false;
      if (row['is_deleted'] == true) deletedIds.add(id);
    }

    final recipientRows = await supabase
        .from(_recipientsTable)
        .select('notification_id, is_read')
        .eq('student_id', studentId);

    for (final r in (recipientRows as List)) {
      final row = r as Map<String, dynamic>;
      final id = row['notification_id'] as String;
      if (row['is_read'] == true) readMap[id] = true;
    }

    final visible = notifications
        .where((n) => !deletedIds.contains(n.id))
        .toList();

    for (final n in visible) {
      n.isRead = readMap[n.id] ?? false;
    }

    return visible;
  }

  @override
  Future<void> markAsRead({
    required String notificationId,
    required String studentId,
  }) async {
    try {
      await supabase.from(_stateTable).upsert({
        'notification_id': notificationId,
        'student_id': studentId,
        'is_read': true,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      }, onConflict: 'notification_id,student_id');

      await supabase
          .from(_recipientsTable)
          .update({'is_read': true})
          .eq('notification_id', notificationId)
          .eq('student_id', studentId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteNotificationOfStudent(
    String notificationId,
    String studentId,
  ) async {
    try {
      await supabase.from(_stateTable).upsert({
        'notification_id': notificationId,
        'student_id': studentId,
        'is_read': true,
        'is_deleted': true,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      }, onConflict: 'notification_id,student_id');

      await supabase
          .from(_recipientsTable)
          .update({'is_read': true})
          .eq('notification_id', notificationId)
          .eq('student_id', studentId);
    } catch (e) {
      rethrow;
    }
  }
}
