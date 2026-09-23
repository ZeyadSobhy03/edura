import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/data/data_source/subject_classes_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/data/model/subject_class_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/data/repositories/subject_classes_repositories.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: SubjectClassesRepositories)
class SubjectClassesRepositoriesImp implements SubjectClassesRepositories {

  final SubjectClassesRemoteDataSource remoteDataSource;
  SubjectClassesRepositoriesImp({required this.remoteDataSource});

  @override
  Future<void> addSubject({required String teacherId, required String subjectName}) {
    return remoteDataSource.addSubject(teacherId: teacherId, subjectName: subjectName);
  }

  @override
  Future<void> deleteSubject({required String id}) {
    return remoteDataSource.deleteSubject(id: id);
  }

  @override
  Future<List<SubjectClassModel>> fetchSubjects({required String teacherId}) {
    return remoteDataSource.fetchSubjects(teacherId: teacherId);
  }

  @override
  Future<void> editSubject({required String id, required String teacherId, required String subjectName}) {
    return remoteDataSource.editSubject(id: id, teacherId: teacherId, subjectName: subjectName);
  }


}