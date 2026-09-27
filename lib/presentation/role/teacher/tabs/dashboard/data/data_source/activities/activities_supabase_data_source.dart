import 'package:edura/core/error/app_error.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/activities/recent_activity_model.dart';
import 'activities_remote_data_source.dart';

@LazySingleton(as: ActivitiesRemoteDataSource)
class ActivitiesSupabaseDataSource implements ActivitiesRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<RecentActivityModel>> getRecentActivities({int limit = 10}) async {
    try {
      final response = await supabase.rpc(
        'teacher_recent_activities',
        params: {'p_limit': limit},
      );

      return (response as List)
          .map((j) => RecentActivityModel.fromJson(j as Map<String, dynamic>))
          .toList();
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }
}