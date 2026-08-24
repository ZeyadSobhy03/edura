import 'package:edura/core/model/chat_args.dart';
import 'package:edura/core/model/chat_conversation_model.dart';
import 'package:edura/core/model/chat_message_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_label.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_chats/section/chat_conversation_card.dart';
import 'package:flutter/material.dart';

class TeacherChats extends StatelessWidget {
  const TeacherChats({super.key});

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final chats = DummyConversationsData.all;
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
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
              if (chats.isEmpty)
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
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    return ChatConversationCard(
                      conversation: chat,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteManger.chat,
                          arguments: ChatArgs(
                            contactName: chat.studentName,
                            isOnline: chat.isOnline,
                            currentUserRole: MessageSender.teacher,
                          ),
                        );
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
