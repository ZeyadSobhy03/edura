import 'package:injectable/injectable.dart';

import '../../../../../../../../core/model/teacher_model.dart';
import '../../../data/repositories/teacher/teacher_repositories.dart';
@injectable
class TeacherUseCase {
  final TeacherRepositories repositories;

  TeacherUseCase({required this.repositories});

  Future<List<TeacherModel>> getTeachers() {
    return repositories.getTeachers();
  }
}
