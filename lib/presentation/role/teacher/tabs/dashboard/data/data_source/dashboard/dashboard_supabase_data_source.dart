import 'package:edura/presentation/role/teacher/tabs/dashboard/data/data_source/dashboard/dashboard_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/dashboard/data/model/dashboard/dashboard_stats.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/error/app_error.dart';

@LazySingleton(as: DashboardRemoteDataSource)
class DashboardSupabaseDataSource implements DashboardRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<DashboardStats> getDashboardStats() async {
    try {
      final response = await supabase.rpc('teacher_dashboard_stats');
      final row = (response as List).first as Map<String, dynamic>;
      return DashboardStats.fromJson(row);
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }
}
