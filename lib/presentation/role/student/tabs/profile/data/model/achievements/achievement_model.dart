class AchievementModel {
  final String id;
  final String emoji;
  final String title;
  final String code;
  final String description;
  final bool isEarned;
  final DateTime? earnedDate;

  AchievementModel({
    required this.id,
    required this.code,
    required this.emoji,
    required this.title,
    required this.description,
    required this.isEarned,
    this.earnedDate,
  });

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: json['code'].toString(),
      emoji: json['emoji'] ?? '🏆',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      code: json['code'] ?? '',
      isEarned: json['is_earned'] ?? false,
      earnedDate: json['earned_date'] != null
          ? DateTime.parse(json['earned_date']).toLocal()
          : null,
    );
  }
}