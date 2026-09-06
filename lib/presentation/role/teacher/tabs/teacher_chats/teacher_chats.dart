

import 'package:edura/core/localization/error_messages.dart';
import 'package:edura/core/model/chat_args.dart';
import 'package:edura/core/model/chat_conversation_model.dart';
import 'package:edura/core/model/chat_message_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_label.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../students/presentation/view_model/student/student_view_model.dart';
import '../teacher_chats/data/data_source/chats_supabase_data_source.dart';
import '../teacher_chats/data/repositories/chats_repositories_imp.dart';
import '../teacher_chats/domain/use_case/chats_use_case.dart';
import '../teacher_chats/section/chat_conversation_card.dart';

class TeacherChats extends StatefulWidget {
  const TeacherChats({super.key});

  @override
  State<TeacherChats> createState() => _TeacherChatsState();
}

class _TeacherChatsState extends State<TeacherChats> {
  bool _isCreating = false;

  final _chatsUseCase = ChatsUseCase(
    repositories: ChatsRepositoriesImp(
      remoteDataSource: ChatsSupabaseDataSource(),
    ),
  );

  @override
  void initState() {
    super.initState();
    context.read<StudentCubit>().getStudents();
  }

  Future<void> _startChat(String studentId, String studentName) async {
    setState(() => _isCreating = true);
    try {
      final teacherId = Supabase.instance.client.auth.currentUser!.id;

      final conversationId = await _chatsUseCase.getOrCreateConversation(
        studentId: studentId,
        teacherId: teacherId,
        studentName: studentName,
      );

      if (!mounted) return;
      Navigator.pushNamed(
        context,
        RouteManger.chat,
        arguments: ChatArgs(
          conversationId: conversationId,
          contactName: studentName,
          isOnline: false,
          currentUserRole: MessageSender.teacher,
        ),
      );
    } finally {
      if (mounted) setState(() => _isCreating = false);
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
              if (state is StudentLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.primary,
                    strokeWidth: 2,
                  ),
                );
              }
              if (state is StudentError) {
                return Center(
                  child: CustomLabel(
                    label: ErrorMessages.get(context, state.error),
                    color: ColorManager.gray,
                  ),
                );
              }
              final students = state is StudentLoaded ? state.students : [];

              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabel(label: l10.chats, fontSize: 20),
                      const SizedBox(height: 8),
                      CustomTextFormedField(
                        hintText: l10.searchChats,
                        prefix: const Icon(Icons.search, color: ColorManager.gray),
                      ),
                      const SizedBox(height: 8),
                      if (students.isEmpty)
                        Center(
                          child: CustomLabel(
                            label: l10.noConversationsYet,
                            color: ColorManager.gray,
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            final student = students[index];

                            // Placeholder conversation just to satisfy
                            // ChatConversationCard's display fields.
                            // The real conversationId is resolved on tap.
                            final placeholder = ChatConversationModel(
                              id: student.id,
                              studentName: student.name,
                              teacherName: null,
                              lastMessage: student.grade,
                              lastMessageTime: DateTime.now(),
                              unreadCount: 0,
                              isOnline: false,
                            );

                            return ChatConversationCard(
                              conversation: placeholder,
                              displayName: student.name,
                              onTap: () => _startChat(student.id, student.name),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          if (_isCreating)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}