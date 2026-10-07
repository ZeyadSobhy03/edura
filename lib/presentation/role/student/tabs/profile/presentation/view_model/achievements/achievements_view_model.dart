import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/achievements/achievement_model.dart';
import '../../../domain/use_case/achievements/achievements_use_case.dart';

@injectable
class AchievementsCubit extends Cubit<AchievementsState> {
  final AchievementsUseCase achievementsUseCase;

  AchievementsCubit({required this.achievementsUseCase})
    : super(AchievementsLoading());

  Future<void> load() async {
    emit(AchievementsLoading());
    try {
      final achievements = await achievementsUseCase.fetchAchievements();
      final stats = await achievementsUseCase.fetchPointsAndRank();
      emit(AchievementsLoaded(achievements, stats.points, stats.rank));
    } catch (e) {
      emit(AchievementsError(e.toString()));
    }
  }
}

sealed class AchievementsState {}

class AchievementsLoading extends AchievementsState {}

class AchievementsLoaded extends AchievementsState {
  final List<AchievementModel> achievements;
  final int points;
  final int rank;

  AchievementsLoaded(this.achievements, this.points, this.rank);
}

class AchievementsError extends AchievementsState {
  final String message;

  AchievementsError(this.message);
}
