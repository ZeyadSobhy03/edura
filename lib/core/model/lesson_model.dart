import 'package:edura/presentation/role/student/tabs/lessons/data/model/student_home_work/homework_submission_model.dart';

class LessonMaterialModel {
  final String id;
  final String lessonId;
  final String name;
  final String fileType;
  final String sizeLabel;
  final String url; // resolved signed URL, ready to open
  final String storagePath; // raw path, needed for delete/re-sign

  LessonMaterialModel({
    required this.id,
    required this.lessonId,
    required this.name,
    required this.fileType,
    required this.sizeLabel,
    required this.url,
    required this.storagePath,
  });

  factory LessonMaterialModel.fromJson(Map<String, dynamic> json) {
    return LessonMaterialModel(
      id: json['id'].toString(),
      lessonId: json['lesson_id'] as String,
      name: json['name'] as String? ?? '',
      fileType: json['file_type'] as String? ?? 'PDF',
      sizeLabel: json['size_label'] as String? ?? '',
      url: json['url'] as String? ?? '',
      storagePath: json['storage_path'] as String? ?? '',
    );
  }
}

class LessonModel {
  final String id;
  final String subject;
  final String teacherId;
  final String title;
  final String teacherName;
  final int durationMinutes;
  final bool isCompleted;
  final double rating;
  final int viewCount;
  bool isPublished;
  final String grade;
  final String gradeId;
  final List<HomeworkSubmissionModel> homeworkSubmissions;

  final double progress; // 0.0 - 1.0
  final String videoThumbnailUrl;
  String videoUrl;
  final String overviewDescription;
  final String teacherNotes;
  final String pdfUrl;
  final List<LessonMaterialModel> materials;

  LessonModel({
    required this.gradeId,
    required this.id,
    required this.subject,
    required this.title,
    required this.teacherName,
    required this.durationMinutes,
    required this.rating,
    required this.progress,
    required this.videoThumbnailUrl,
    required this.videoUrl,
    required this.teacherId,
    required this.overviewDescription,
    required this.teacherNotes,
    required this.pdfUrl,
    required this.materials,
    required this.isCompleted,
    required this.viewCount,
    required this.isPublished,
    required this.homeworkSubmissions,
    required this.grade,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      teacherId: json['teacher_id'] ?? '',
      gradeId: json['grade_id'] ?? '',
      grade: json['grade'] ?? '',
      homeworkSubmissions:
          (json['homework_submissions'] as List<dynamic>? ?? [])
              .map((e) => HomeworkSubmissionModel.fromJson(e))
              .toList(),
      isPublished: json['is_published'] ?? false,
      viewCount: json['view_count'] ?? 0,
      isCompleted: json['is_completed'] ?? false,
      id: json['id'].toString(),
      subject: json['subject'] ?? '',
      title: json['title'] ?? '',
      teacherName: json['teacher_name'] ?? '',
      durationMinutes: json['duration_minutes'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      progress: (json['progress'] ?? 0).toDouble(),
      videoThumbnailUrl: json['video_thumbnail_url'] ?? '',
      videoUrl: json['video_url'] ?? '',
      overviewDescription: json['overview_description'] ?? '',
      teacherNotes: json['teacher_notes'] ?? '',
      pdfUrl: json['pdf_url'] ?? '',
      materials: (json['materials'] as List<dynamic>? ?? [])
          .map((e) => LessonMaterialModel.fromJson(e))
          .toList(),
    );
  }
}

