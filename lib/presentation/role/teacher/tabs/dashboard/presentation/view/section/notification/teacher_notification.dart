import 'dart:developer';

import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_button.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/teacher_notification/notification_audience.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/teacher_notification/notification_model.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/teacher_notification/notification_read_stats.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view/section/notification/section/student_picker.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view/section/notification/teacher_notification_body.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view/widgets/notification_tile.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/presentation/view_model/teacher_notification/teacher_notification_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/students/presentation/view_model/student/student_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../../l10n/app_localizations.dart';

class TeacherNotification extends StatefulWidget {
  const TeacherNotification({super.key});

  @override
  State<TeacherNotification> createState() => _TeacherNotificationState();
}

class _TeacherNotificationState extends State<TeacherNotification> {
  NotificationAudience _audience = NotificationAudience.allStudents;
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  final _selectedStudentIds = <String>[];
  final _selectedStudentNames = <String>[];
  final _notifications = <NotificationModel>[];
  bool _isPinned = false;
  bool _isSending = false;
  NotificationReadStats? _pendingReadStats;

  String? get _teacherId => Supabase.instance.client.auth.currentUser?.id;

  @override
  void initState() {
    super.initState();
    final teacherId = _teacherId;
    if (teacherId != null) {
      context.read<TeacherNotificationCubit>().getNotificationsByTeacher(
        teacherId,
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  bool get _canSend =>
      _titleController.text.trim().isNotEmpty &&
      _messageController.text.trim().isNotEmpty &&
      (_audience != NotificationAudience.individual ||
          _selectedStudentIds.isNotEmpty);

  void _send() {
    final teacherId = _teacherId;
    if (!_canSend || teacherId == null) return;
    setState(() => _isSending = true);
    context.read<TeacherNotificationCubit>().createNotification(
      teacherId: teacherId,
      title: _titleController.text.trim(),
      message: _messageController.text.trim(),
      audience: _audience.databaseValue,
      recipientIds: _selectedStudentIds,
      isPinned: _isPinned,
    );
  }

  Future<void> _openStudentPicker() async {
    context.read<StudentCubit>().getStudents();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => StudentPicker(
        onDone: () => Navigator.pop(sheetContext),
        selectedStudentIds: _selectedStudentIds,
        selectedStudentNames: _selectedStudentNames,
        onSelectionChanged:
            ({required id, required name, required isSelected}) {
              setState(() {
                if (isSelected) {
                  _selectedStudentIds.add(id);
                  _selectedStudentNames.add(name);
                } else {
                  _selectedStudentIds.remove(id);
                  _selectedStudentNames.remove(name);
                }
              });
            },
      ),
    );
  }

  void _onAction(NotificationAction action, NotificationModel notification) {
    final teacherId = _teacherId;
    if (teacherId == null) return;
    switch (action) {
      case NotificationAction.pin:
        context.read<TeacherNotificationCubit>().setPinned(
          notification.id,
          !notification.isPinned,
          teacherId: teacherId,
        );
      case NotificationAction.details:
        _pendingReadStats = null;
        context.read<TeacherNotificationCubit>().getReadStats(notification.id);
      case NotificationAction.delete:
        context.read<TeacherNotificationCubit>().deleteNotification(
          notification.id,
          teacherId: teacherId,
        );
    }
  }

  void _clearForm() {
    setState(() {
      _titleController.clear();
      _messageController.clear();
      _selectedStudentIds.clear();
      _selectedStudentNames.clear();
      _isPinned = false;
      _audience = NotificationAudience.allStudents;
    });
  }

  void _showReadDetails(NotificationReadStats stats, int recipientCount) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(
          AppLocalizations.of(context)!.notificationReadDetails,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        content: Text(
          AppLocalizations.of(context)!.notificationReadStats(
            stats.readCount,
            stats.totalRecipients,
            recipientCount,
          ),
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          CustomTextButton(
            text: AppLocalizations.of(context)!.close,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return BlocConsumer<TeacherNotificationCubit, TeacherNotificationState>(
      listener: (context, state) {
        if (state is TeacherNotificationCreated) {
          setState(() => _isSending = false);
          _clearForm();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10.notificationSentSuccessfully)),
          );
        } else if (state is TeacherNotificationLoaded) {
          setState(() {
            _notifications
              ..clear()
              ..addAll(state.notifications);
          });
        } else if (state is TeacherNotificationReadStatsLoaded) {
          _pendingReadStats = state.stats;
          context.read<TeacherNotificationCubit>().getRecipients(
            state.stats.notificationId,
          );
        } else if (state is TeacherNotificationRecipientsLoaded &&
            _pendingReadStats != null) {
          _showReadDetails(_pendingReadStats!, state.recipients.length);
          _pendingReadStats = null;
        } else if (state is TeacherNotificationError) {
          if (_isSending) {
            setState(() => _isSending = false);
          }
          log('Error: ${state.message}');
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is TeacherNotificationLoading;
        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0,
            centerTitle: true,
            title: CustomText(
              text: l10.sendNotification,
              style: TextStyle(
                color: ColorManager.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: TeacherNotificationBody(
                      onAudienceChanged: (audience) =>
                          setState(() => _audience = audience),
                      openStudentPicker: _openStudentPicker,
                      selectedStudentNames: _selectedStudentNames,
                      audience: _audience,
                      isLoading: isLoading,
                      titleController: _titleController,
                      messageController: _messageController,
                      titleOnChanged: (_) => setState(() {}),
                      messageOnChanged: (_) => setState(() {}),
                      isPinned: _isPinned,
                      notifications: _notifications,
                      isPinnedOnChanged: (value) =>
                          setState(() => _isPinned = value),
                      onAction: _onAction,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _canSend && !_isSending ? _send : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary,
                        disabledBackgroundColor: ColorManager.gray.withValues(
                          alpha: .3,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isSending
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              l10.sendNotificationButton,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
