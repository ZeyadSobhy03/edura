class Grade {
  final String id;
  final String teacherId;
  final String name;
  final double monthlyAmount;

  const Grade({
    required this.id,
    required this.teacherId,
    required this.name,
    required this.monthlyAmount,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'] as String,
      teacherId: json['teacher_id'] as String,
      name: json['name'] as String,
      monthlyAmount: (json['monthly_amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacher_id': teacherId,
      'name': name,
      'monthly_amount': monthlyAmount,
    };
  }

  Grade copyWith({String? name, double? monthlyAmount}) {
    return Grade(
      id: id,
      teacherId: teacherId,
      name: name ?? this.name,
      monthlyAmount: monthlyAmount ?? this.monthlyAmount,
    );
  }
}