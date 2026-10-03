import 'dart:io';

import 'package:edura/presentation/role/student/tabs/home/data/data_source/student_stats/student_stats_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/error/app_error.dart';
import '../../model/student_stats/student_stats.dart';

@LazySingleton(as: StudentStatsRemoteDataSource)
class StudentStatsSupabaseDataSource implements StudentStatsRemoteDataSource {
  final supabase = Supabase.instance.client;
  @override
  Future<StudentStatsModel> fetchStats({required String studentId}) async {
    try {
      final res = await supabase
          .rpc('get_student_stats', params: {'p_student_id': studentId});

      final rows = res as List;
      if (rows.isEmpty) {
        return const StudentStatsModel(
            lessons: 0, completedLessons: 0, studyMinutes: 0, averageScore: 0);
      }
      return StudentStatsModel.fromJson(rows.first as Map<String, dynamic>);
    } on SocketException {
      throw const NoInternetError();
    } on PostgrestException {
      throw ServerError();
    }
  }
}
