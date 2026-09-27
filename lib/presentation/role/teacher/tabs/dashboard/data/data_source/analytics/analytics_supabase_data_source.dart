import 'package:edura/core/error/app_error.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/analytics/teacher_analytics_model.dart';
import 'analytics_remote_data_source.dart';

@LazySingleton(as: AnalyticsRemoteDataSource)
class AnalyticsSupabaseDataSource implements AnalyticsRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<TeacherAnalytics> getAnalytics(String range) async {
    try {
      final response = await supabase.rpc(
        'teacher_analytics_data',
        params: {'p_range': range},
      );

      return TeacherAnalytics.fromJson(response as Map<String, dynamic>);
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }
}
