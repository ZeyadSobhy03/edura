import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

import '../../../../../core/model/chat_message_model.dart';
import '../../../../../l10n/app_localizations.dart';
import 'section/chat_bubble.dart';
import 'section/chat_header.dart';
import 'section/chat_input_field.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final List<ChatMessageModel> _messages = List<ChatMessageModel>.from(
    DummyChatData.all,
  );
  final ScrollController _scrollController = ScrollController();

  void _sendMessage(String text) {
    setState(() {
      _messages.add(
        ChatMessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          sender: MessageSender.student,
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
        automaticallyImplyLeading: false,
        backgroundColor: ColorManager.white,
        elevation: 0,
        title: const ChatHeader(isOnline: true),
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
                      return ChatBubble(message: _messages[index]);
                    },
                  ),
          ),
          ChatInputField(onSend: _sendMessage),
        ],
      ),
    );
  }
}
