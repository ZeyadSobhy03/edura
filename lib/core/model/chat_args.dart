import 'chat_message_model.dart';

class ChatArgs {
  final String conversationId;

  final String contactName;
  final bool isOnline;
  final MessageSender currentUserRole;
  final List<ChatMessageModel>? initialMessages;

  ChatArgs({
    required this.contactName,
    required this.isOnline,
    required this.currentUserRole,
    this.initialMessages, required this.conversationId,
  });
}
