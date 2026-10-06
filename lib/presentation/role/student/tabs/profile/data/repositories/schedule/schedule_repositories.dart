import '../../model/schedule/class_schedule_model.dart';

abstract class ScheduleRepositories {
  Future<List<ClassScheduleModel>> fetchMySchedule();
}
