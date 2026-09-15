import 'dart:io';

class NewLessonModel {
  String title;
  int durationMinutes;
  String subject;
  String description;
  bool isPremium;
  bool isPublished;
  File? videoFile;
  File? pdfFile;

  NewLessonModel({
    this.title = '',
    this.durationMinutes = 0,
    this.subject = 'Mathematics',
    this.description = '',
    this.isPremium = false,
    this.isPublished = true,
    this.videoFile,
    this.pdfFile,
  });

  factory NewLessonModel.fromJson(Map<String, dynamic> json) {
    return NewLessonModel(
      title: json['title'] as String? ?? '',
      durationMinutes: json['durationMinutes'] as int? ?? 0,
      subject: json['subject'] as String? ?? 'Mathematics',
      description: json['description'] as String? ?? '',
      isPremium: json['isPremium'] as bool? ?? false,
      isPublished: json['isPublished'] as bool? ?? true,
      pdfFile: json['pdfFile'] != null ? File(json['pdfFile'] as String) : null,
      videoFile: json['videoFile'] != null
          ? File(json['videoFile'] as String)
          : null,
    );
  }
}
