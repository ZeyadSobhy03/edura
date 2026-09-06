import 'chat_message_model.dart';

class ChatConversationModel {
  final String id;
  final String studentName;
  final String? teacherName;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isOnline;

  ChatConversationModel({
    required this.id,
    required this.studentName,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.teacherName,
    this.isOnline = false,
  });

  factory ChatConversationModel.fromJson(Map<String, dynamic> json) {
    return ChatConversationModel(
      teacherName: json['teacher']?['name'],
      id: json['id'].toString(),
      studentName: json['student']?['name'] ?? '',
      lastMessage: json['last_message'] ?? '',
      lastMessageTime: DateTime.parse(json['last_message_time']),
      unreadCount: json['unread_count'] ?? 0,
      isOnline: json['is_online'] ?? false,
    );
  }
  String contactName(MessageSender viewerRole) {
    return viewerRole == MessageSender.teacher
        ? studentName
        : (teacherName ?? '');
  }
}


class DummyConversationsData {
  static List<ChatConversationModel> all = [
    ChatConversationModel(
      id: 'c1',
      studentName: 'Alex Johnson',
      lastMessage: 'Thank you so much!',
      lastMessageTime: DateTime.now().copyWith(hour: 10, minute: 37),
      unreadCount: 0,
      isOnline: true,
    ),
    ChatConversationModel(
      id: 'c2',
      studentName: 'Emma Davis',
      lastMessage: 'Could you explain eigenvalues?',
      lastMessageTime: DateTime.now().copyWith(hour: 9, minute: 12),
      unreadCount: 2,
      isOnline: true,
    ),
    ChatConversationModel(
      id: 'c3',
      studentName: 'James Wilson',
      lastMessage: "I missed today's class",
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 1,
      isOnline: false,
    ),
    ChatConversationModel(
      id: 'c4',
      studentName: 'Sofia Martinez',
      lastMessage: 'Got it, thanks!',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
      isOnline: true,
    ),
  ];
}