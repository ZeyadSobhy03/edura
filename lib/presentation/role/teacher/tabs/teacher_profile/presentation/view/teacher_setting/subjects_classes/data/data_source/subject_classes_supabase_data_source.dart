import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/data/data_source/subject_classes_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_setting/subjects_classes/data/model/subject_class_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: SubjectClassesRemoteDataSource)
class SubjectClassesSupabaseDataSource
    implements SubjectClassesRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<void> addSubject({
    required String teacherId,
    required String subjectName,
  }) async {
    await supabase.from('subjects').insert({
      'teacher_id': teacherId,
      'subject_name': subjectName,
    });
  }

  @override
  Future<void> deleteSubject({required String id}) async {
    await supabase.from('subjects').delete().eq('id', id);
  }

  @override
  Future<List<SubjectClassModel>> fetchSubjects({
    required String teacherId,
  }) async {
    final response = await supabase
        .from('subject_class_stats')
        .select()
        .eq('teacher_id', teacherId)
        .order('subject_name');

    return (response as List)
        .map((json) => SubjectClassModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> editSubject({
    required String id,
    required String subjectName,
    required String teacherId,
  }) async {
    try {
       await supabase
          .from('subjects')
          .update({'subject_name': subjectName})
          .eq('id', id)
          .eq('teacher_id', teacherId)
          .select()
          .single();
    } catch (e) {
      rethrow;
    }
  }
}
