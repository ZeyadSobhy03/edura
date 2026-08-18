enum AttendanceMark { present, absent, late }

class StudentAttendanceModel {
  final String id;
  final String name;
  final String grade;
  AttendanceMark status;

  StudentAttendanceModel({
    required this.id,
    required this.name,
    required this.grade,
    required this.status,
  });
}
class DummyAttendanceTakingData {
  static List<StudentAttendanceModel> students = [
    StudentAttendanceModel(id: '1', name: 'Emma Davis', grade: 'Grade 12', status: AttendanceMark.present),
    StudentAttendanceModel(id: '2', name: 'James Wilson', grade: 'Grade 11', status: AttendanceMark.absent),
    StudentAttendanceModel(id: '3', name: 'Alex Johnson', grade: 'Grade 11', status: AttendanceMark.present),
    StudentAttendanceModel(id: '4', name: 'Sofia Martinez', grade: 'Grade 10', status: AttendanceMark.late),
    StudentAttendanceModel(id: '5', name: 'Liam Chen', grade: 'Grade 11', status: AttendanceMark.present),
    StudentAttendanceModel(id: '6', name: 'Zara Ahmed', grade: 'Grade 12', status: AttendanceMark.present),
  ];
}