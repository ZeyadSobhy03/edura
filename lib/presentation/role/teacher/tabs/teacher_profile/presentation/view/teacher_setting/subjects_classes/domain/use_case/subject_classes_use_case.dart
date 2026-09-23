import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/data/repositories/subject_classes_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/subject_class_model.dart';

@injectable
class SubjectClassesUseCase {
  final SubjectClassesRepositories repositories;

  SubjectClassesUseCase({required this.repositories});

  Future<List<SubjectClassModel>> fetchSubjects({required String teacherId}) {
    return repositories.fetchSubjects(teacherId: teacherId);
  }

  Future<void> addSubject({
    required String teacherId,
    required String subjectName,
  }) {
    return repositories.addSubject(
      teacherId: teacherId,
      subjectName: subjectName,
    );
  }

  Future<void> deleteSubject({required String id}) {
    return repositories.deleteSubject(id: id);
  }
  Future<void> editSubject({
    required String id,
    required String teacherId,
    required String subjectName,
  }) {
    return repositories.editSubject(
      id: id,
      teacherId: teacherId,
      subjectName: subjectName,
    );
  }
}
