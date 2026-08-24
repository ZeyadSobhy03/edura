import 'package:edura/core/model/chat_args.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

import '../../../../../core/model/chat_message_model.dart';
import '../../../../../l10n/app_localizations.dart';
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
  late final List<ChatMessageModel> _messages;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messages = List<ChatMessageModel>.from(
      widget.chat.initialMessages ?? DummyChatData.all,
    );
  }

  void _sendMessage(String text) {
    setState(() {
      _messages.add(
        ChatMessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          sender: widget.chat.currentUserRole,
          time: DateTime.now(),
        ),
      );
    });

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
            child: _messages.isEmpty
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
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isMe =
                          message.sender == widget.chat.currentUserRole;
                      return ChatBubble(message: message, isMe: isMe);
                    },
                  ),
          ),
          ChatInputField(onSend: _sendMessage),
        ],
      ),
    );
  }
}
