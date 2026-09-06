import 'package:edura/core/model/chat_conversation_model.dart';
import 'package:edura/core/model/chat_message_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_chats/data/repositories/chats_repositories.dart';

import '../data_source/chats_remote_data_source.dart';

class ChatsRepositoriesImp implements ChatsRepositories {
  final ChatsRemoteDataSource remoteDataSource;

  ChatsRepositoriesImp({required this.remoteDataSource});

  @override
  Future<ChatMessageModel> sendMessage({
    required String conversationId,
    required String text,
    required String sender,
  }) {
    return remoteDataSource.sendMessage(
      conversationId: conversationId,
      text: text,
      sender: sender,
    );
  }

  @override
  Future<List<ChatMessageModel>> loadMessages(String conversationId) {
    return remoteDataSource.loadMessages(conversationId);
  }

  @override
  Future<List<ChatConversationModel>> loadConversations({
    required MessageSender role,
  }) {
    return remoteDataSource.loadConversations(role: role);
  }

  @override
  Future<String> getOrCreateConversation({
    required String studentId,
    required String teacherId,
    required String studentName,
  }) {
    return remoteDataSource.getOrCreateConversation(
      studentId: studentId,
      teacherId: teacherId,
      studentName: studentName,
    );
  }
}
