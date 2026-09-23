import '../model/subject_class_model.dart';

abstract class SubjectClassesRepositories {
  Future<List<SubjectClassModel>> fetchSubjects({required String teacherId});

  Future<void> addSubject({required String teacherId, required String subjectName});
  Future<void> editSubject({
    required String id,
    required String teacherId,
    required String subjectName,
  });
  Future<void> deleteSubject({required String id});

}