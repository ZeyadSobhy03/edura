class AchievementModel {
  final String id;
  final String emoji;
  final String title;
  final String description;
  final bool isEarned;
  final DateTime? earnedDate;

  AchievementModel({
    required this.id,
    required this.emoji,
    required this.title,
    required this.description,
    required this.isEarned,
    this.earnedDate,
  });

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: json['id'].toString(),
      emoji: json['emoji'] ?? '🏆',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isEarned: json['is_earned'] ?? false,
      earnedDate: json['earned_date'] != null
          ? DateTime.parse(json['earned_date'])
          : null,
    );
  }
}

class DummyAchievementData {
  static List<AchievementModel> all = [
    AchievementModel(
      id: '1',
      emoji: '🔥',
      title: 'Week Streak',
      description: '7-day study streak',
      isEarned: true,
      earnedDate: DateTime(2026, 1, 10),
    ),
    AchievementModel(
      id: '2',
      emoji: '⭐',
      title: 'High Scorer',
      description: 'Score 90%+ on an exam',
      isEarned: true,
      earnedDate: DateTime(2026, 1, 8),
    ),
    AchievementModel(
      id: '3',
      emoji: '⚡',
      title: 'Speed Reader',
      description: 'Complete 5 lessons in 1 day',
      isEarned: true,
      earnedDate: DateTime(2026, 1, 5),
    ),
    AchievementModel(
      id: '4',
      emoji: '🏆',
      title: 'Top of Class',
      description: 'Reach rank #1',
      isEarned: false,
    ),
    AchievementModel(
      id: '5',
      emoji: '💯',
      title: 'Perfect Exam',
      description: 'Score 100% on any exam',
      isEarned: false,
    ),
    AchievementModel(
      id: '6',
      emoji: '🌟',
      title: 'Month Streak',
      description: '30-day study streak',
      isEarned: false,
    ),
  ];
}
