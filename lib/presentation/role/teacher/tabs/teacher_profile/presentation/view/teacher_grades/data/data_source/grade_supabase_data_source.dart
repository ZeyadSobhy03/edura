import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/data/data_source/grade_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_grades/data/model/grade_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: GradeRemoteDataSource)
class GradeSupabaseDataSource implements GradeRemoteDataSource {
  final supabse = Supabase.instance.client;

  @override
  Future<void> addGrade({
    required String teacherId,
    required String name,
    required double monthlyAmount,
  }) async {
    await supabse.from('grades').insert({
      'teacher_id': teacherId,
      'name': name,
      'monthly_amount': monthlyAmount,
    });
  }

  @override
  Future<void> deleteGrade({required String id}) async {
    await supabse.from('grades').delete().eq('id', id);
  }

  @override
  Future<List<Grade>> fetchGrades({String? teacherId}) async {
    var query = supabse.from('grades').select();
    if (teacherId != null) {
      query = query.eq('teacher_id', teacherId);
    }
    final response = await query.order('name');

    return (response as List)
        .map((json) => Grade.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> updateGrade({
    required String id,
    required String name,
    required double monthlyAmount,
  }) async {
    await supabse
        .from('grades')
        .update({'name': name, 'monthly_amount': monthlyAmount})
        .eq('id', id);
  }
}
