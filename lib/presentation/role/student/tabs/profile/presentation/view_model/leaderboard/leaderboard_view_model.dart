import 'package:edura/presentation/role/student/tabs/profile/domain/use_case/leaderboard/leaderboard_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../core/model/leaderboard_entry_model.dart';
import '../../../../../../../../core/model/teacher_option.dart';

@injectable
class LeaderboardCubit extends Cubit<LeaderboardState> {
  final LeaderboardUseCase leaderboardUseCase;

  LeaderboardCubit({required this.leaderboardUseCase})
    : super(LeaderboardLoading());

  Future<void> load({String? teacherId}) async {
    emit(LeaderboardLoading());
    try {
      final teachers = await leaderboardUseCase.fetchMyTeachers();
      if (teachers.isEmpty) {
        emit(
          LeaderboardLoaded(
            teachers: const [],
            selectedTeacherId: null,
            entries: const [],
          ),
        );
        return;
      }
      final selected = teachers.any((t) => t.id == teacherId)
          ? teacherId!
          : teachers.first.id;
      final entries = await leaderboardUseCase.fetchLeaderboard(selected);
      emit(
        LeaderboardLoaded(
          teachers: teachers,
          selectedTeacherId: selected,
          entries: entries,
        ),
      );
    } catch (e) {
      emit(LeaderboardError(e.toString()));
    }
  }
}

sealed class LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardLoaded extends LeaderboardState {
  final List<TeacherOption> teachers;
  final String? selectedTeacherId;
  final List<LeaderboardEntryModel> entries;

  LeaderboardLoaded({
    required this.teachers,
    required this.selectedTeacherId,
    required this.entries,
  });
}

class LeaderboardError extends LeaderboardState {
  final String message;

  LeaderboardError(this.message);
}
