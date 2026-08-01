enum MessageSender { student, teacher }

class ChatMessageModel {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime time;
  final bool isRead;

  ChatMessageModel({
    required this.id,
    required this.text,
    required this.sender,
    required this.time,
    this.isRead = false,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'].toString(),
      text: json['text'] ?? '',
      sender: MessageSender.values.firstWhere(
            (e) => e.name == json['sender'],
        orElse: () => MessageSender.student,
      ),
      time: DateTime.parse(json['time']),
      isRead: json['is_read'] ?? false,
    );
  }
}

class DummyChatData {
  static List<ChatMessageModel> all = [
    ChatMessageModel(
      id: '1',
      text: 'Hello! Do you have a question about today\'s lesson?',
      sender: MessageSender.teacher,
      time: DateTime.now().subtract(const Duration(minutes: 30)),
      isRead: true,
    ),
    ChatMessageModel(
      id: '2',
      text: 'Yes, I didn\'t understand the integration by parts example.',
      sender: MessageSender.student,
      time: DateTime.now().subtract(const Duration(minutes: 28)),
      isRead: true,
    ),
    ChatMessageModel(
      id: '3',
      text: 'No problem, let\'s go through it step by step. Which part confused you?',
      sender: MessageSender.teacher,
      time: DateTime.now().subtract(const Duration(minutes: 25)),
      isRead: true,
    ),
    ChatMessageModel(
      id: '4',
      text: 'Choosing which function to differentiate first.',
      sender: MessageSender.student,
      time: DateTime.now().subtract(const Duration(minutes: 20)),
      isRead: false,
    ),
  ];
}