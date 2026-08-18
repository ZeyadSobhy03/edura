class AnalyticsStatModel {
  final String value;
  final String label;
  final String changeLabel;
  final bool isPositive;

  AnalyticsStatModel({
    required this.value,
    required this.label,
    required this.changeLabel,
    this.isPositive = true,
  });
}

class WeeklyPointModel {
  final String label;
  final double value;

  WeeklyPointModel({required this.label, required this.value});
}

class MonthlyRevenueModel {
  final String monthLabel;
  final double value;

  MonthlyRevenueModel({required this.monthLabel, required this.value});
}

class ExamPerformanceModel {
  final String examTitle;
  final double avgScore;
  final double passRate;

  ExamPerformanceModel({
    required this.examTitle,
    required this.avgScore,
    required this.passRate,
  });
}
class DummyAnalyticsData {
  static List<WeeklyPointModel> weeklyStudentGrowth = [
    WeeklyPointModel(label: 'Mon', value: 8),
    WeeklyPointModel(label: 'Tue', value: 12),
    WeeklyPointModel(label: 'Wed', value: 15),
    WeeklyPointModel(label: 'Thu', value: 14),
    WeeklyPointModel(label: 'Fri', value: 19),
    WeeklyPointModel(label: 'Sat', value: 24),
    WeeklyPointModel(label: 'Sun', value: 30),
  ];
}
