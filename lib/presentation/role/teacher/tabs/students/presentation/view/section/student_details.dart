import 'dart:developer';

import 'package:edura/core/model/chat_args.dart';
import 'package:edura/core/model/chat_message_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../data/model/student_detail_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/student/student_view_model.dart';
import '../../../../teacher_chats/data/data_source/chats_supabase_data_source.dart';
import '../../../../teacher_chats/data/repositories/chats_repositories_imp.dart';
import '../../../../teacher_chats/domain/use_case/chats_use_case.dart';
import '../widgets/attendance_history_tab.dart';
import '../widgets/contact_info_card.dart';
import '../widgets/exam_result_tab.dart';
import '../widgets/lesson_progress_tab.dart';
import '../widgets/student_details_header.dart';
import '../widgets/student_details_tab_selector.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key, required this.student});

  final StudentModel student;

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  StudentDetailsTab _tab = StudentDetailsTab.progress;
  bool _isCreatingChat = false;

  final _chatsUseCase = ChatsUseCase(
    repositories: ChatsRepositoriesImp(
      remoteDataSource: ChatsSupabaseDataSource(),
    ),
  );

  @override
  void initState() {
    super.initState();

    context.read<StudentCubit>().getStudentDetails(
      studentId: widget.student.id,
    );
  }

  Future<void> _startChat() async {
    setState(() => _isCreatingChat = true);
    try {
      final teacherId = Supabase.instance.client.auth.currentUser!.id;

      final conversationId = await _chatsUseCase.getOrCreateConversation(
        studentId: widget.student.id,
        teacherId: teacherId,
        studentName: widget.student.name,
      );

      if (!mounted) return;
      Navigator.pushNamed(
        context,
        RouteManger.chat,
        arguments: ChatArgs(
          conversationId: conversationId,
          contactName: widget.student.name,
          isOnline: false,
          currentUserRole: MessageSender.teacher,
        ),
      );
    } finally {
      if (mounted) setState(() => _isCreatingChat = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Stack(
        children: [
          BlocBuilder<StudentCubit, StudentState>(
            builder: (context, state) {
              if (state is StudentDetailsLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.primary,
                    strokeWidth: 2,
                  ),
                );
              }

              if (state is StudentDetailsLoaded) {
                final student = state.student;

                return SafeArea(
                  child: Column(
                    children: [
                      StudentDetailsHeader(student: student),

                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StudentDetailsTabSelector(
                                selected: _tab,
                                onChanged: (tab) {
                                  setState(() {
                                    _tab = tab;
                                  });
                                },
                              ),

                              const SizedBox(height: 16),

                              if (_tab == StudentDetailsTab.progress) ...[
                                LessonProgressTab(
                                  lessonProgress: student.lessonProgress,
                                ),

                                ContactInfoCard(
                                  contactInfo: ContactInfo(
                                    phone: student.phone,
                                    parentPhone: student.parentPhone,
                                    email: student.email,
                                  ),
                                ),
                              ] else if (_tab == StudentDetailsTab.exams)
                                ExamResultTab(examResults: student.examResults)
                              else
                                AttendanceHistoryTab(
                                  records: student.attendanceRecords,
                                ),
                            ],
                          ),
                        ),
                      ),

                      if (_tab == StudentDetailsTab.progress)
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _startChat,
                                  icon: const Icon(
                                    Icons.chat_bubble_outline,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    l10.message,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    alertParent(student.parentPhone);
                                  },
                                  icon: Icon(
                                    Icons.notifications_none,
                                    size: 18,
                                    color: ColorManager.black,
                                  ),
                                  label: Text(
                                    l10.alertParent,
                                    style: TextStyle(color: ColorManager.black),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    side: BorderSide(
                                      color: ColorManager.gray.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              }

              if (state is StudentError) {
                log("Error: ${state.error}");
                return Center(
                  child: CustomText(
                    text: l10.errorOccurred,
                    style: TextStyle(color: ColorManager.red),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
          if (_isCreatingChat)
            Container(
              color: Colors.black26,
              child: const Center(
                child: CircularProgressIndicator(
                  color: ColorManager.primary,
                  strokeWidth: 2,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void alertParent(String phoneNumber) async {
    final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber");

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: ColorManager.red,
            content: Text(AppLocalizations.of(context)!.whatsappNotInstalled),
          ),
        );
      }
    }
  }
}
