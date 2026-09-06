import 'package:edura/core/model/chat_message_model.dart';

import '../../../../../../../core/model/chat_conversation_model.dart';

abstract class ChatsRemoteDataSource {
  Future<List<ChatConversationModel>> loadConversations({
    required MessageSender role,
  });

  Future<String> getOrCreateConversation({
    required String studentId,
    required String teacherId,
    required String studentName,

  });

  Future<ChatMessageModel> sendMessage({
    required String conversationId,
    required String text,
    required String sender,
  });

  Future<List<ChatMessageModel>> loadMessages(String conversationId);
}
