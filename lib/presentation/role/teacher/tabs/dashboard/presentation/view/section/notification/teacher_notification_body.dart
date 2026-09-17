import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/teacher_notification/notification_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../../core/widgets/custom_label.dart';
import '../../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../../core/widgets/custom_text_formed_field.dart';
import '../../../../../../../../../l10n/app_localizations.dart';
import '../../../../data/model/teacher_notification/notification_audience.dart';
import '../../widgets/audience_option_tile.dart';
import '../../widgets/notification_tile.dart';
import '../../widgets/pin_announcement_toggle.dart';
import '../../widgets/student_multi_select_field.dart';

class TeacherNotificationBody extends StatelessWidget {
  const TeacherNotificationBody({
    super.key,
    required this.onAudienceChanged,
    required this.openStudentPicker,
    required this.selectedStudentNames,
    required this.audience,
    required this.isLoading,
    required this.titleController,
    required this.messageController,
    required this.isPinned,
    required this.notifications,
    this.titleOnChanged,
    this.messageOnChanged,
    required this.isPinnedOnChanged,
    required this.onAction,
  });

  final ValueChanged<NotificationAudience> onAudienceChanged;
  final VoidCallback openStudentPicker;
  final List<String> selectedStudentNames;
  final NotificationAudience audience;
  final bool isLoading;

  final TextEditingController titleController;

  final TextEditingController messageController;

  final bool isPinned;

  final List<NotificationModel> notifications;

  final void Function(String)? titleOnChanged;
  final void Function(String)? messageOnChanged;
  final ValueChanged<bool> isPinnedOnChanged;
  final void Function(NotificationAction action, NotificationModel notification)
  onAction;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(
          label: l10.audience,
          fontSize: 12,
          color: ColorManager.black.withValues(alpha: .5),
        ),
        const SizedBox(height: 8),
        AudienceOptionTile(
          label: l10.allStudents,
          isSelected: audience == NotificationAudience.allStudents,
          onTap: isLoading
              ? () {}
              : () => onAudienceChanged(NotificationAudience.allStudents),
        ),
        AudienceOptionTile(
          label: l10.individual,
          isSelected: audience == NotificationAudience.individual,
          onTap: isLoading
              ? () {}
              : () => onAudienceChanged(NotificationAudience.individual),
        ),
        if (audience == NotificationAudience.individual) ...[
          const SizedBox(height: 4),
          StudentMultiSelectField(
            selectedNames: selectedStudentNames,
            onTap: isLoading ? () {} : openStudentPicker,
          ),
        ],
        const SizedBox(height: 20),
        CustomLabel(
          label: l10.notificationTitle,
          fontSize: 12,
          color: ColorManager.black.withValues(alpha: .5),
        ),
        const SizedBox(height: 8),
        CustomTextFormedField(
          controller: titleController,
          onChanged: titleOnChanged,
          hintText: l10.notificationTitleHint,
        ),
        const SizedBox(height: 20),
        CustomLabel(
          label: l10.messageBody,
          fontSize: 12,
          color: ColorManager.black.withValues(alpha: .5),
        ),
        const SizedBox(height: 8),
        CustomTextFormedField(
          controller: messageController,
          onChanged: messageOnChanged,
          hintText: l10.messageBodyHint,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
        ),
        const SizedBox(height: 20),
        PinAnnouncementToggle(
          value: isPinned,
          onChanged: isLoading ? (_) {} : isPinnedOnChanged,
        ),
        if (notifications.isNotEmpty) ...[
          const SizedBox(height: 28),
          CustomText(
            text: l10.notifications,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...notifications.map(
            (notification) => NotificationTile(
              notification: notification,
              onAction: (action) => onAction(action, notification),
            ),
          ),
        ],
      ],
    );
  }
}
