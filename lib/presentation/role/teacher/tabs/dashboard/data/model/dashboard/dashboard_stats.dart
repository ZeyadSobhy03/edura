class DashboardStats {
  final int totalStudents;
  final int activeStudents;
  final double monthlyRevenue;
  final int todaysClasses;

  const DashboardStats({
    required this.totalStudents,
    required this.activeStudents,
    required this.monthlyRevenue,
    required this.todaysClasses,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) => DashboardStats(
    totalStudents: (json['total_students'] as num).toInt(),
    activeStudents: (json['active_students'] as num).toInt(),
    monthlyRevenue: (json['monthly_revenue'] as num).toDouble(),
    todaysClasses: (json['todays_classes'] as num).toInt(),
  );
}