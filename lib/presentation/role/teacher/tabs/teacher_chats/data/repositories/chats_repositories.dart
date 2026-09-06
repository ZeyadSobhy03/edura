import '../../../../../../../core/model/chat_conversation_model.dart';
import '../../../../../../../core/model/chat_message_model.dart';

abstract class ChatsRepositories {

  Future<List<ChatConversationModel>> loadConversations({
    required MessageSender role,
  });  Future<ChatMessageModel> sendMessage({
    required String conversationId,
    required String text,
    required String sender,

  });
  Future<List<ChatMessageModel>> loadMessages(String conversationId);
  Future<String> getOrCreateConversation({
    required String studentId,
    required String teacherId,
    required String studentName,

  });

}