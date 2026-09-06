import 'package:edura/core/model/chat_args.dart';
import 'package:edura/core/model/chat_conversation_model.dart';
import 'package:edura/core/model/chat_message_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/teacher/tabs/students/presentation/view_model/teacher/teacher_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/localization/error_messages.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../teacher/tabs/teacher_chats/data/data_source/chats_supabase_data_source.dart';
import '../../../teacher/tabs/teacher_chats/data/repositories/chats_repositories_imp.dart';
import '../../../teacher/tabs/teacher_chats/domain/use_case/chats_use_case.dart';
import '../../../teacher/tabs/teacher_chats/section/chat_conversation_card.dart';

class StudentChatsScreen extends StatefulWidget {
  const StudentChatsScreen({super.key});

  @override
  State<StudentChatsScreen> createState() => _StudentChatsScreenState();
}

class _StudentChatsScreenState extends State<StudentChatsScreen> {
  bool _isCreating = false;

  final _chatsUseCase = ChatsUseCase(
    repositories: ChatsRepositoriesImp(
      remoteDataSource: ChatsSupabaseDataSource(),
    ),
  );

  @override
  void initState() {
    super.initState();
    context.read<TeacherCubit>().getTeachers();
  }

  Future<void> _startChat(String teacherId, String teacherName) async {
    setState(() => _isCreating = true);
    try {
      final studentId = Supabase.instance.client.auth.currentUser!.id;

      final conversationId = await _chatsUseCase.getOrCreateConversation(
        studentId: studentId,
        teacherId: teacherId,
        studentName: '',
      );

      if (!mounted) return;
      Navigator.pushNamed(
        context,
        RouteManger.chat,
        arguments: ChatArgs(
          conversationId: conversationId,
          contactName: teacherName,
          isOnline: false,
          currentUserRole: MessageSender.student,
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
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.chat,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<TeacherCubit, TeacherState>(
              builder: (context, state) {
                if (state is TeacherLoading || state is TeacherInitial) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primary,
                      strokeWidth: 2,
                    ),
                  );
                }

                if (state is TeacherError) {
                  return Center(
                    child: CustomText(
                      text: ErrorMessages.get(context, state.error),
                      style: TextStyle(
                        color: ColorManager.black.withValues(alpha: 0.5),
                      ),
                    ),
                  );
                }

                final teachers = (state as TeacherLoaded).teachers;

                if (teachers.isEmpty) {
                  return Center(
                    child: CustomText(
                      text: l10.noConversationsYet,
                      style: TextStyle(
                        color: ColorManager.black.withValues(alpha: 0.5),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: teachers.length,
                  itemBuilder: (context, index) {
                    final teacher = teachers[index];

                    final placeholder = ChatConversationModel(
                      id: teacher.id,
                      studentName: '',
                      teacherName: teacher.name,
                      lastMessage: teacher.subject ?? '',
                      lastMessageTime: DateTime.now(),
                      unreadCount: 0,
                      isOnline: false,
                    );

                    return ChatConversationCard(
                      conversation: placeholder,
                      displayName: teacher.name,
                      onTap: () => _startChat(teacher.id, teacher.name),
                    );
                  },
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
      ),
    );
  }
}
