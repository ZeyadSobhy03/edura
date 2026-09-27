import 'package:edura/presentation/role/teacher/tabs/dashboard/domain/use_case/analytics/analytics_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/analytics/teacher_analytics_model.dart';


@injectable
class AnalyticsCubit extends Cubit<AnalyticsState> {
  final AnalyticsUseCase useCase;
  AnalyticsCubit(this.useCase) : super(AnalyticsInitial());

  Future<void> load(String range) async {
    emit(AnalyticsLoading());
    try {
      emit(AnalyticsLoaded(await useCase.getAnalytics(range)));
    } catch (e) {
      emit(AnalyticsError(e.toString()));
    }
  }
}

sealed class AnalyticsState {}
class AnalyticsInitial extends AnalyticsState {}
class AnalyticsLoading extends AnalyticsState {}
class AnalyticsLoaded extends AnalyticsState {
  final TeacherAnalytics data;
  AnalyticsLoaded(this.data);
}
class AnalyticsError extends AnalyticsState {
  final String message;
  AnalyticsError(this.message);
}