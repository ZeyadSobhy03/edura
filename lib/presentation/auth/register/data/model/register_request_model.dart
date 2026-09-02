class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final String grade;
  final String school;
  final String phone;
  final String parentPhone;

  const RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.grade,
    required this.school,
    required this.phone,
    required this.parentPhone,
  });
}