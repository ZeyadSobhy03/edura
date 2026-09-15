import 'dart:io';

class NewHomeworkModel {
  String title;
  String description;
  String subject;
  DateTime? dueDate;
  bool isPublished;
  List<File> attachments;

  NewHomeworkModel({
    this.title = '',
    this.description = '',
    this.subject = 'Mathematics',
    this.dueDate,
    this.isPublished = true,
    this.attachments = const [],
  });

  factory NewHomeworkModel.fromJson(Map<String, dynamic> json) {
    return NewHomeworkModel(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      subject: json['subject'] as String? ?? 'Mathematics',
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate'] as String) : null,
      isPublished: json['isPublished'] as bool? ?? true,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => File(e as String))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'subject': subject,
      'dueDate': dueDate?.toIso8601String(),
      'isPublished': isPublished,
      'attachments': attachments.map((f) => f.path).toList(),
    };
  }
}

