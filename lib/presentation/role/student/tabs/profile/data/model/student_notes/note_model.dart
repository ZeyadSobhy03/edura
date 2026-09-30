class NoteModel {
  final String id;
  final String title;
  final String content;
  final String lessonId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String subject;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.lessonId,
    required this.subject,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      subject: json['subject'] ?? '',
      id: json['id'].toString(),
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      lessonId: json['lesson_id'].toString(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}