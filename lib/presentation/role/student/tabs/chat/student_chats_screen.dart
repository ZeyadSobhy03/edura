import 'package:edura/core/model/chat_args.dart';
import 'package:edura/core/model/chat_message_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/model/chat_conversation_model.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../teacher/tabs/teacher_chats/section/chat_conversation_card.dart';

class StudentChatsScreen extends StatelessWidget {
  const StudentChatsScreen({super.key});

  static final List<ChatConversationModel> _dummyConversations = [
    ChatConversationModel(
      id: 't1',
      studentName: 'Dr. Sarah Mitchell',
      lastMessage: 'No problem, let\'s go through it step by step.',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 25)),
      unreadCount: 1,
      isOnline: true,
    ),
  ];

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
        child: _dummyConversations.isEmpty
            ? Center(
                child: CustomText(
                  text: l10.noConversationsYet,
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.5),
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _dummyConversations.length,
                itemBuilder: (context, index) {
                  final conversation = _dummyConversations[index];
                  return ChatConversationCard(
                    conversation: conversation,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.chat,
                        arguments: ChatArgs(
                          contactName: conversation.studentName,
                          isOnline: conversation.isOnline,
                          currentUserRole: MessageSender.student,
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
