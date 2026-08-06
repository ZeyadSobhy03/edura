class LeaderboardEntryModel {
  final String id;
  final String name;
  final String? avatarUrl;
  final int points;
  final int rank;
  final bool isCurrentUser;

  LeaderboardEntryModel({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.points,
    required this.rank,
    this.isCurrentUser = false,
  });

  factory LeaderboardEntryModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntryModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      avatarUrl: json['avatar_url'],
      points: json['points'] ?? 0,
      rank: json['rank'] ?? 0,
      isCurrentUser: json['is_current_user'] ?? false,
    );
  }
}

class DummyLeaderboardData {
  static List<LeaderboardEntryModel> all = [
    LeaderboardEntryModel(id: '1', name: 'Sara Ahmed', points: 980, rank: 1),
    LeaderboardEntryModel(id: '2', name: 'Omar Khaled', points: 940, rank: 2),
    LeaderboardEntryModel(id: '3', name: 'Laila Hassan', points: 910, rank: 3),
    LeaderboardEntryModel(
      id: '4',
      name: 'Ziyad Sobhy',
      points: 860,
      rank: 4,
      isCurrentUser: true,
    ),
    LeaderboardEntryModel(id: '5', name: 'Mona Tarek', points: 820, rank: 5),
    LeaderboardEntryModel(id: '6', name: 'Youssef Adel', points: 790, rank: 6),
    LeaderboardEntryModel(id: '7', name: 'Nour Fathy', points: 750, rank: 7),
    LeaderboardEntryModel(id: '8', name: 'Kareem Sami', points: 700, rank: 8),
  ];
}
