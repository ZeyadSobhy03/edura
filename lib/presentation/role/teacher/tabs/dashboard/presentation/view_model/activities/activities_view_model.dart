
import 'package:edura/presentation/role/teacher/tabs/dashboard/domain/use_case/activities/activities_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/activities/recent_activity_model.dart';

@injectable
class ActivitiesCubit extends Cubit<ActivitiesState> {
  final ActivitiesUseCase useCase;

  ActivitiesCubit(this.useCase) : super(ActivitiesInitial());

  Future<void> load() async {
    emit(ActivitiesLoading());
    try {
      emit(ActivitiesLoaded(await useCase.getRecentActivities()));
    } catch (e) {
      emit(ActivitiesError(e.toString()));
    }
  }

  Future<void> deleteActivity({required String activityId}) async {
    final current = state;
    if (current is! ActivitiesLoaded) return;

    final previous = current.activities;

    emit(ActivitiesLoaded(previous.where((a) => a.id != activityId).toList()));

    try {
      await useCase.deleteActivity(activityId: activityId);
    } catch (_) {
      emit(ActivitiesLoaded(previous));
    }
  }
}

sealed class ActivitiesState {}

class ActivitiesInitial extends ActivitiesState {}

class ActivitiesLoading extends ActivitiesState {}

class ActivitiesLoaded extends ActivitiesState {
  final List<RecentActivityModel> activities;

  ActivitiesLoaded(this.activities);
}

class ActivitiesError extends ActivitiesState {
  final String message;

  ActivitiesError(this.message);
}
