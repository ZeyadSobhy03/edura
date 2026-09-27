class ChartPoint {
  final String label;
  final double value;
  ChartPoint({required this.label, required this.value});

  factory ChartPoint.fromJson(Map<String, dynamic> j) => ChartPoint(
    label: j['label'] as String,
    value: (j['value'] as num).toDouble(),
  );
}

class ExamPerformance {
  final String title;
  final double avgScore;
  final double passRate;
  ExamPerformance({required this.title, required this.avgScore, required this.passRate});

  factory ExamPerformance.fromJson(Map<String, dynamic> j) => ExamPerformance(
    title: j['title'] as String? ?? '',
    avgScore: (j['avg_score'] as num?)?.toDouble() ?? 0,
    passRate: (j['pass_rate'] as num?)?.toDouble() ?? 0,
  );
}

class TeacherAnalytics {
  final int totalStudents;
  final double avgScore;
  final int activeLessons;
  final double revenueTotal;
  final List<ChartPoint> weeklyGrowth;
  final List<ChartPoint> monthlyRevenue;
  final double lessonCompletionPct;
  final double attendanceRatePct;
  final List<ChartPoint> dailyAttendance;
  final ExamPerformance? latestExam;

  TeacherAnalytics({
    required this.totalStudents,
    required this.avgScore,
    required this.activeLessons,
    required this.revenueTotal,
    required this.weeklyGrowth,
    required this.monthlyRevenue,
    required this.lessonCompletionPct,
    required this.attendanceRatePct,
    required this.dailyAttendance,
    required this.latestExam,
  });

  factory TeacherAnalytics.fromJson(Map<String, dynamic> j) => TeacherAnalytics(
    totalStudents: (j['total_students'] as num).toInt(),
    avgScore: (j['avg_score'] as num).toDouble(),
    activeLessons: (j['active_lessons'] as num).toInt(),
    revenueTotal: (j['revenue_total'] as num).toDouble(),
    weeklyGrowth: (j['weekly_growth'] as List)
        .map((e) => ChartPoint.fromJson(e as Map<String, dynamic>))
        .toList(),
    monthlyRevenue: (j['monthly_revenue'] as List)
        .map((e) => ChartPoint.fromJson(e as Map<String, dynamic>))
        .toList(),
    lessonCompletionPct: (j['lesson_completion_pct'] as num).toDouble(),
    attendanceRatePct: (j['attendance_rate_pct'] as num).toDouble(),
    dailyAttendance: (j['daily_attendance'] as List)
        .map((e) => ChartPoint.fromJson(e as Map<String, dynamic>))
        .toList(),
    latestExam: j['latest_exam'] == null
        ? null
        : ExamPerformance.fromJson(j['latest_exam'] as Map<String, dynamic>),
  );
}