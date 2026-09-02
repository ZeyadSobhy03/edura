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
}