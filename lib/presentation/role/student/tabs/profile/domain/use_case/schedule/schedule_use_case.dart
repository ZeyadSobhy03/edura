import 'package:edura/presentation/role/student/tabs/profile/data/repositories/schedule/schedule_repositories.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/schedule/class_schedule_model.dart';

@injectable
class ScheduleUseCase {
  final ScheduleRepositories scheduleRepositories;

  ScheduleUseCase({required this.scheduleRepositories});

  Future<List<ClassScheduleModel>> fetchMySchedule() {
    return scheduleRepositories.fetchMySchedule();
  }
}
