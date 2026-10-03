import 'dart:io';

class NewHomeworkModel {
  String title;
  String id;
  String description;
  String subject;
  DateTime? dueDate;
  bool isPublished;
  List<File> attachments;
  String gradeId;
  String grade;
  String status;

  NewHomeworkModel({
    this.id = '',
    this.title = '',
    this.description = '',
    this.subject = 'Mathematics',
    this.dueDate,
    this.isPublished = true,
    List<File>? attachments,
    this.grade = '',
    this.gradeId = '',
    this.status = 'pending',
  }) : attachments = List<File>.from(attachments ?? []);

  factory NewHomeworkModel.fromJson(Map<String, dynamic> json) {
    return NewHomeworkModel(
      id: json['id'] as String? ?? '',
      grade: json['grade'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      gradeId: json['gradeId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      subject: json['subject'] as String? ?? 'Mathematics',
      dueDate: json['due_date'] != null
          ? DateTime.parse(json['due_date'] as String)
          : null,
      isPublished: json['isPublished'] as bool? ?? true,
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => File(e as String))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
       'id': id,
      'title': title,
      'description': description,
      'subject': subject,
      'dueDate': dueDate?.toIso8601String(),
      'isPublished': isPublished,
      'grade': grade,
      'gradeId': gradeId,
      'status': status,
      'attachments': attachments.map((f) => f.path).toList(),
    };
  }
}
