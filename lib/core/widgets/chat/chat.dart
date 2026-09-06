import 'dart:developer';

import 'package:edura/core/model/chat_args.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_chats/presentation/view_model/chats_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../localization/error_messages.dart';
import 'section/chat_bubble.dart';
import 'section/chat_header.dart';
import 'section/chat_input_field.dart';

class Chat extends StatefulWidget {
  const Chat({super.key, required this.chat});

  final ChatArgs chat;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MessagesCubit>().getMessages(widget.chat.conversationId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: ColorManager.white,
        elevation: 0,
        title: ChatHeader(
          contactName: widget.chat.contactName,
          isOnline: widget.chat.isOnline,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<MessagesCubit, MessagesState>(
              builder: (context, state) {
                if (state is MessagesLoading || state is MessagesInitial) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primary,
                      strokeWidth: 2,
                    ),
                  );
                }
                if (state is MessagesError) {
                  log("Error: ${state.error}");
                  return Center(
                    child: Text(
                      ErrorMessages.get(context, state.error),
                      style: TextStyle(color: ColorManager.gray),
                    ),
                  );
                }
                final messages = (state as MessagesLoaded).messages;
                return messages.isEmpty
                    ? Center(
                  child: Text(
                    l10.noMessages,
                    style: TextStyle(color: ColorManager.gray),
                  ),
                )
                    : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe =
                        message.sender == widget.chat.currentUserRole;
                    return ChatBubble(message: message, isMe: isMe);
                  },
                );
              },
              listener: (context, state) {
                if (state is MessagesLoaded) _scrollToBottom();
              },
            ),
          ),

          ChatInputField(
            onSend: (message) {
              context.read<MessagesCubit>().sendMessage(
                text: message,
                sender: widget.chat.currentUserRole.name,
                conversationId: widget.chat.conversationId,
              );
            },
          ),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }
}