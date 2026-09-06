import '../../../../../../../core/model/chat_conversation_model.dart';
import '../../../../../../../core/model/chat_message_model.dart';
import '../../data/repositories/chats_repositories.dart';

class ChatsUseCase {
  final ChatsRepositories repositories;

  ChatsUseCase({required this.repositories});

  Future<List<ChatConversationModel>> loadConversations({
    required MessageSender role,
  }) {
    return repositories.loadConversations(role: role);
  }

  Future<ChatMessageModel> sendMessage({
    required String conversationId,
    required String text,
    required String sender,
  }) {
    return repositories.sendMessage(
      conversationId: conversationId,
      text: text,
      sender: sender,
    );
  }

  Future<List<ChatMessageModel>> loadMessages(String conversationId) {
    return repositories.loadMessages(conversationId);
  }
  Future<String> getOrCreateConversation({
    required String studentId,
    required String studentName,

    required String teacherId,
  }) {
    return repositories.getOrCreateConversation(
      studentName: studentName,
      studentId: studentId,
      teacherId: teacherId,
    );
  }
}
