
import '../../../../../../../../core/model/teacher_model.dart';

abstract class TeacherRemoteDataSource {
  Future<List<TeacherModel>> getTeachers();

  Future<String> getOrCreateConversation({
    required String studentId,
    required String teacherId,
  });
}