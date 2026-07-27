class LessonMaterialModel {
  final String id;
  final String name;
  final String fileType;
  final String sizeLabel;
  final String url;

  LessonMaterialModel({
    required this.id,
    required this.name,
    required this.fileType,
    required this.sizeLabel,
    required this.url,
  });

  factory LessonMaterialModel.fromJson(Map<String, dynamic> json) {
    return LessonMaterialModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      fileType: json['file_type'] ?? 'PDF',
      sizeLabel: json['size_label'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

class LessonModel {
  final String id;
  final String subject;
  final String title;
  final String teacherName;
  final int durationMinutes;
  final bool isCompleted;
  final double rating;

  final double progress; // 0.0 - 1.0
  final String videoThumbnailUrl;
  final String videoUrl;
  final String overviewDescription;
  final String teacherNotes;
  final String pdfUrl;
  final List<LessonMaterialModel> materials;

  LessonModel({
    required this.id,
    required this.subject,
    required this.title,
    required this.teacherName,
    required this.durationMinutes,
    required this.rating,
    required this.progress,
    required this.videoThumbnailUrl,
    required this.videoUrl,
    required this.overviewDescription,
    required this.teacherNotes,
    required this.pdfUrl,
    required this.materials, required this.isCompleted,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
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
class DummyLessonData {
  static LessonModel quantumMechanics = LessonModel(
    isCompleted: false,
    id: '1',
    subject: 'Physics',
    title: 'Quantum Mechanics Introduction',
    teacherName: 'Dr. Sarah Mitchell',
    durationMinutes: 38,
    rating: 4.8,
    progress: 0.6,
    videoThumbnailUrl:
    'https://images.unsplash.com/photo-1636466497217-26a8cbeaf0aa?w=800',
    videoUrl:
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    overviewDescription:
    'Explore wave-particle duality, Schrödinger\'s equation, and the uncertainty principle.',
    teacherNotes:
    'Focus on understanding the conceptual meaning before drilling computation. Work through each example step by step.',
    pdfUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
    materials: [
      LessonMaterialModel(

        id: 'm1',
        name: 'Chapter 1 Notes.pdf',
        fileType: 'PDF',
        sizeLabel: '2.3 MB',
        url: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
      LessonMaterialModel(
        id: 'm2',
        name: 'Practice Problems.pdf',
        fileType: 'PDF',
        sizeLabel: '2.3 MB',
        url: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
      LessonMaterialModel(
        id: 'm3',
        name: 'Formula Sheet.pdf',
        fileType: 'PDF',
        sizeLabel: '2.3 MB',
        url: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
    ],
  );

  static LessonModel calculusDerivatives = LessonModel(
    isCompleted: false,
    id: '2',
    subject: 'Mathematics',
    title: 'Calculus Derivatives',
    teacherName: 'Mr. James Carter',
    durationMinutes: 25,
    rating: 4.5,
    progress: 0.3,
    videoThumbnailUrl:
    'https://images.unsplash.com/photo-1509228468518-180dd4864904?w=800',
    videoUrl:
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    overviewDescription:
    'Learn the fundamentals of derivatives, including limits, the power rule, and the chain rule.',
    teacherNotes:
    'Encourage students to visualize the slope of the tangent line before jumping to formulas.',
    pdfUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
    materials: [
      LessonMaterialModel(
        id: 'm4',
        name: 'Derivative Rules.pdf',
        fileType: 'PDF',
        sizeLabel: '1.8 MB',
        url: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
    ],
  );
  static LessonModel chemistryReactions = LessonModel(
    isCompleted: false,
    id: '3',
    subject: 'Chemistry',
    title: 'Chemical Reactions',
    teacherName: 'Dr. Emily Johnson',
    durationMinutes: 30,
    rating: 4.7,
    progress: 0.5,
    videoThumbnailUrl:
    'https://images.unsplash.com/photo-1581091215361-6f8e1b9c8f2d?w=800',
    videoUrl:
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
    overviewDescription:
    'Understand the different types of chemical reactions, including synthesis, decomposition, and combustion.',
    teacherNotes:
    'Highlight the importance of balancing equations and understanding reaction mechanisms.',
    pdfUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
    materials: [
      LessonMaterialModel(
        id: 'm5',
        name: 'Reaction Types.pdf',
        fileType: 'PDF',
        sizeLabel: '2.0 MB',
        url: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
      LessonMaterialModel(
        id: 'm6',
        name: 'Lab Safety Guidelines.pdf',
        fileType: 'PDF',
        sizeLabel: '1.5 MB',
        url: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
    ],
  );

  static List<LessonModel> all = [quantumMechanics, calculusDerivatives, chemistryReactions];
}
