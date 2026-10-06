import '../../model/schedule/class_schedule_model.dart';

abstract class ScheduleRemoteDataSource {
  Future<List<ClassScheduleModel>> fetchMySchedule();
}