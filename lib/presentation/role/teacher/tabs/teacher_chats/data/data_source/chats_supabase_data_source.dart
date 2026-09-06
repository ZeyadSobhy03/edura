import 'dart:developer';

import 'package:edura/core/error/app_error.dart';
import 'package:edura/core/model/chat_conversation_model.dart';
import 'package:edura/core/model/chat_message_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_chats/data/data_source/chats_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatsSupabaseDataSource implements ChatsRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<ChatConversationModel>> loadConversations({
    required MessageSender role,
  }) async {
    final userId = supabase.auth.currentUser!.id;

    try {
      if (role == MessageSender.teacher) {
        final response = await supabase
            .from('conversations')
            .select()
            .eq('teacher_id', userId)
            .order('last_message_time', ascending: false);

        return response
            .map((json) => ChatConversationModel.fromJson(json))
            .toList();
      } else {
        final response = await supabase
            .from('conversations')
            .select('*, teacher:teacher_id(name)')
            .eq('student_id', userId)
            .order('last_message_time', ascending: false);

        return response
            .map((json) => ChatConversationModel.fromJson(json))
            .toList();
      }
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }

  @override
  Future<String> getOrCreateConversation({
    required String studentId,
    required String teacherId,
    required String studentName,

  }) async {
    try {
      final existing = await supabase
          .from('conversations')
          .select('id')
          .eq('student_id', studentId)
          .eq('teacher_id', teacherId)

          .maybeSingle();

      if (existing != null) {
        return existing['id'].toString();
      }

      final inserted = await supabase
          .from('conversations')
          .insert({
        'student_id': studentId,
        'teacher_id': teacherId,
        'last_message': '',
        'student_name': studentName,
        'last_message_time': DateTime.now().toIso8601String(),
        'is_online': false,
      })
          .select('id')
          .single();

      return inserted['id'].toString();
    } on AppError {
      rethrow;
    } catch (e) {
      log('getOrCreateConversation error: $e');

      throw ServerError();
    }
  }

  @override
  Future<ChatMessageModel> sendMessage({
    required String conversationId,
    required String text,
    required String sender,
  }) async {
    try {
      final response = await supabase
          .from('messages')
          .insert({
            'conversation_id': conversationId,
            'text': text,
            'sender': sender,
          })
          .select()
          .single();

      await supabase
          .from('conversations')
          .update({
            'last_message': text,
            'last_message_time': DateTime.now().toIso8601String(),
          })
          .eq('id', conversationId);
      return ChatMessageModel.fromJson(response);
    } on AppError catch (e) {
      log("Error in sendMessage: ${e.toString()}");
      rethrow;
    } catch (e) {
      log('Error in sendMessage: ${e.toString()}');
      throw ServerError();
    }
  }

  @override
  Future<List<ChatMessageModel>> loadMessages(String conversationId) async{

    try {
      final response = await supabase
          .from('messages')
          .select()
          .eq('conversation_id', conversationId)
          .order('time', ascending: true);

      return response.map((json) => ChatMessageModel.fromJson(json)).toList();
    } on AppError catch (e) {
      log("Error in loadMessages: ${e.toString()}");
      rethrow;
    } catch (e) {
      log('Error in loadMessages: $e');
      throw ServerError();
    }
  }
}
