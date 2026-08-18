import 'dart:io';

class NewLessonDraftModel {
  String title;
  String duration;
  String subject;
  String description;
  bool isPremium;
  File? videoFile;
  File? pdfFile;

  NewLessonDraftModel({
    this.title = '',
    this.duration = '',
    this.subject = 'Mathematics',
    this.description = '',
    this.isPremium = false,
    this.videoFile,
    this.pdfFile,
  });
}