import 'package:edura/presentation/role/student/tabs/profile/data/model/schedule/class_schedule_model.dart';
import 'package:edura/presentation/role/student/tabs/profile/data/repositories/schedule/schedule_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/schedule/schedule_remote_data_source.dart';

@LazySingleton(as: ScheduleRepositories)
class ScheduleRepositoriesImp implements ScheduleRepositories {
  final ScheduleRemoteDataSource scheduleRemoteDataSource;

  ScheduleRepositoriesImp({required this.scheduleRemoteDataSource});

  @override
  Future<List<ClassScheduleModel>> fetchMySchedule() {
    return scheduleRemoteDataSource.fetchMySchedule();
  }
}
