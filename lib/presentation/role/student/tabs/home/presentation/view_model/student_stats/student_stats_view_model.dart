import 'package:edura/presentation/role/student/tabs/home/data/model/student_stats/student_stats.dart';
import 'package:edura/presentation/role/student/tabs/home/domain/use_case/student_stats/student_stats_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class StudentStatsCubit extends Cubit<StudentStatsState> {
  final StudentStatsUseCase studentStatsUseCase;

  StudentStatsCubit({required this.studentStatsUseCase})
    : super(StudentStatsInitial());

  Future<void> fetchStats({required String studentId}) async {
    emit(StudentStatsLoading());
    try {
      final stats = await studentStatsUseCase.fetchStats(studentId: studentId);
      emit(StudentStatsLoaded(stats: stats));
    } catch (e) {
      emit(StudentStatsError(message: e.toString()));
    }
  }
}

sealed class StudentStatsState {}

class StudentStatsInitial extends StudentStatsState {}

class StudentStatsLoading extends StudentStatsState {}

class StudentStatsLoaded extends StudentStatsState {
  final StudentStatsModel stats;

  StudentStatsLoaded({required this.stats});
}

class StudentStatsError extends StudentStatsState {
  final String message;

  StudentStatsError({required this.message});
}
