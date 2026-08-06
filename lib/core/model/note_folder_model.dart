class NoteFolderModel {
  final String id;
  final String name;
  final int notesCount;
  final String icon; 

  NoteFolderModel({
    required this.id,
    required this.name,
    required this.notesCount,
    required this.icon,
  });

  factory NoteFolderModel.fromJson(Map<String, dynamic> json) {
    return NoteFolderModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      notesCount: json['notes_count'] ?? 0,
      icon: json['icon'] ?? 'general',
    );
  }
}