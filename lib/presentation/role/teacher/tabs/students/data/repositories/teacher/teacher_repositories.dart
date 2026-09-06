

import '../../../../../../../../core/model/teacher_model.dart';

abstract class TeacherRepositories {
  Future<List<TeacherModel>> getTeachers();
}