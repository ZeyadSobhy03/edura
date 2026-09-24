import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/data_source/dashboard/dashboard_remote_data_source.dart';
import '../../../data/model/dashboard/dashboard_stats.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRemoteDataSource dataSource;

  DashboardCubit(this.dataSource) : super(DashboardInitial());

  Future<void> load() async {
    emit(DashboardLoading());
    try {
      emit(DashboardLoaded(await dataSource.getDashboardStats()));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}

sealed class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardStats stats;

  DashboardLoaded(this.stats);
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}
