import 'note_folder_model.dart';

class NoteModel {
  final String id;
  final String title;
  final String subject;
  final String preview;
  final DateTime date;
  final String folderId;

  NoteModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.preview,
    required this.date,
    required this.folderId,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      subject: json['subject'] ?? '',
      preview: json['preview'] ?? '',
      date: DateTime.parse(json['date']),
      folderId: json['folder_id'].toString(),
    );
  }
}


class DummyNotesData {
  static List<NoteFolderModel> folders = [
    NoteFolderModel(id: 'f1', name: 'Mathematics', notesCount: 8, icon: 'mathematics'),
    NoteFolderModel(id: 'f2', name: 'Physics', notesCount: 5, icon: 'physics'),
    NoteFolderModel(id: 'f3', name: 'General', notesCount: 3, icon: 'general'),
  ];

  static List<NoteModel> notes = [
    NoteModel(
      id: 'n1',
      title: 'Chain Rule Summary',
      subject: 'Mathematics',
      preview: "If f(x) = g(h(x)), then f'(x) = g'(h(x))·h'(x)...",
      date: DateTime(2026, 1, 16),
      folderId: 'f1',
    ),
    NoteModel(
      id: 'n2',
      title: 'Wave Equations',
      subject: 'Physics',
      preview: 'Speed of light c = λf. For EM waves in vacuum...',
      date: DateTime(2026, 1, 14),
      folderId: 'f2',
    ),
    NoteModel(
      id: 'n3',
      title: 'Integration by Parts',
      subject: 'Mathematics',
      preview: '∫u dv = uv − ∫v du. Choose u using LIATE rule...',
      date: DateTime(2026, 1, 12),
      folderId: 'f1',
    ),
  ];
}