class TeacherModel {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? subject;
  final String? bio;

  TeacherModel({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.subject,
    this.bio,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'],
      phone: json['phone'],
      subject: json['subject'],
      bio: json['bio'],
    );
  }
}