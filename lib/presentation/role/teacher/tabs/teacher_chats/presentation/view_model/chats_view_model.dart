import 'package:edura/core/error/app_error.dart';
import 'package:edura/core/model/chat_conversation_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/model/chat_message_model.dart';
import '../../domain/use_case/chats_use_case.dart';

class ChatsCubit extends Cubit<ChatsState> {
  final ChatsUseCase chatsUseCase;

  ChatsCubit({required this.chatsUseCase}) : super(ChatsInitial());
  Future<void> getChats({required MessageSender role}) async {
    emit(ChatsLoading());
    try {
      final chats = await chatsUseCase.loadConversations(role: role);
      emit(ChatsLoaded(chats: chats));
    } on AppError catch (e) {
      emit(ChatsError(error: e));
    }
  }
}

sealed class ChatsState {}

class ChatsInitial extends ChatsState {}

class ChatsLoading extends ChatsState {}

class ChatsLoaded extends ChatsState {
  final List<ChatConversationModel> chats;

  ChatsLoaded({required this.chats});
}

final class ChatsError extends ChatsState {
  final AppError error;

  ChatsError({required this.error});
}

class MessagesCubit extends Cubit<MessagesState> {
  final ChatsUseCase chatsUseCase;

  MessagesCubit({required this.chatsUseCase}) : super(MessagesInitial());

  List<ChatMessageModel> _messages = [];

  Future<void> getMessages(String conversationId) async {
    emit(MessagesLoading());
    try {
      _messages = await chatsUseCase.loadMessages(conversationId);
      emit(MessagesLoaded(messages: List.of(_messages)));
    } on AppError catch (e) {
      emit(MessagesError(error: e));
    }
  }

  Future<void> sendMessage({
    required String conversationId,
    required String text,
    required String sender,
  }) async {
    try {
      final newMessage = await chatsUseCase.sendMessage(
        conversationId: conversationId,
        text: text,
        sender: sender,
      );
      _messages = [..._messages, newMessage];
      emit(MessagesLoaded(messages: List.of(_messages)));
    } on AppError catch (e) {
      emit(MessagesError(error: e));
    }
  }
}

sealed class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<ChatMessageModel> messages;

  MessagesLoaded({required this.messages});
}

final class MessagesError extends MessagesState {
  final AppError error;

  MessagesError({required this.error});
}
