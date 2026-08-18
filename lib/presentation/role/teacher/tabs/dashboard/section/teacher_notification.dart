import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/notification_audience.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../widgets/audience_option_tile.dart';
import '../widgets/pin_announcement_toggle.dart';
import '../widgets/student_multi_select_field.dart';

class TeacherNotification extends StatefulWidget {
  const TeacherNotification({super.key});

  @override
  State<TeacherNotification> createState() => _TeacherNotificationState();
}

class _TeacherNotificationState extends State<TeacherNotification> {
  NotificationAudience _audience = NotificationAudience.allStudents;
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isPinned = false;
  final List<String> _selectedStudents = [];
  bool _isSending = false;

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  bool get _canSend {
    if (_titleController.text.trim().isEmpty) return false;
    if (_messageController.text.trim().isEmpty) return false;
    if (_audience == NotificationAudience.individual &&
        _selectedStudents.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> _send() async {
    if (!_canSend) return;

    setState(() => _isSending = true);

    // TODO: insert into Supabase `notifications` table, targeting the chosen audience
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;
    setState(() => _isSending = false);

    final l10 = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10.notificationSentSuccessfully)));
    Navigator.pop(context);
  }

  void _openStudentPicker() {
    // TODO: push a student selection screen/bottom sheet, receive selected names back
    // e.g.:
    // final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => StudentPickerScreen(initiallySelected: _selectedStudents)));
    // if (result is List<String>) setState(() => _selectedStudents = result);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: l10.audience,
                      style: TextStyle(
                        color: ColorManager.black.withValues(alpha: 0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    AudienceOptionTile(
                      label: l10.allStudents,
                      isSelected: _audience == NotificationAudience.allStudents,
                      onTap: () => setState(
                        () => _audience = NotificationAudience.allStudents,
                      ),
                    ),
                    AudienceOptionTile(
                      label: l10.activeOnly,
                      isSelected: _audience == NotificationAudience.activeOnly,
                      onTap: () => setState(
                        () => _audience = NotificationAudience.activeOnly,
                      ),
                    ),
                    AudienceOptionTile(
                      label: l10.individual,
                      isSelected: _audience == NotificationAudience.individual,
                      onTap: () => setState(
                        () => _audience = NotificationAudience.individual,
                      ),
                    ),

                    // Only shown when "Individual" is selected — this is the one
                    // functional gap I flagged in the original screenshot design.
                    if (_audience == NotificationAudience.individual) ...[
                      const SizedBox(height: 4),
                      StudentMultiSelectField(
                        selectedNames: _selectedStudents,
                        onTap: _openStudentPicker,
                      ),
                    ],

                    const SizedBox(height: 20),
                    CustomText(
                      text: l10.notificationTitle,
                      style: TextStyle(
                        color: ColorManager.black.withValues(alpha: 0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormedField(
                      controller: _titleController,
                      onChanged: (_) => setState(() {}),
                      hintText: l10.notificationTitleHint,
                    ),

                    const SizedBox(height: 20),
                    CustomText(
                      text: l10.messageBody,
                      style: TextStyle(
                        color: ColorManager.black.withValues(alpha: 0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormedField(
                      hintText: l10.messageBodyHint,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,

                      controller: _messageController,
                      onChanged: (_) => setState(() {}),
                      maxLines: 6,
                    ),

                    const SizedBox(height: 20),
                    PinAnnouncementToggle(
                      value: _isPinned,
                      onChanged: (value) => setState(() => _isPinned = value),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_canSend && !_isSending) ? _send : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    disabledBackgroundColor: ColorManager.gray.withValues(
                      alpha: 0.3,
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
  }
}
