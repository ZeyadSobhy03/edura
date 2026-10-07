import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/attendance/attendance_model.dart';
import '../../../domain/use_case/attendance/attendance_use_case.dart';

@injectable
class AttendanceCubit extends Cubit<AttendanceState> {
  final AttendanceUseCase attendanceUseCase;

  AttendanceCubit({required this.attendanceUseCase})
      : super(AttendanceInitial());

  Future<void> getStudentAttendance(String studentId) async {
    emit(AttendanceLoading());
    try {
      final records = await attendanceUseCase.getStudentAttendance(studentId);
      if (isClosed) return;
      emit(AttendanceLoaded(records: records));
    } catch (e) {
      if (isClosed) return;
      emit(AttendanceError(message: e.toString()));
    }
  }
}

sealed class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceError extends AttendanceState {
  final String message;
  AttendanceError({required this.message});
}

class AttendanceLoaded extends AttendanceState {
  final List<AttendanceRecordModel> records;
  AttendanceLoaded({required this.records});

  int _count(AttendanceStatus s) => records.where((r) => r.status == s).length;

  int get presentCount => _count(AttendanceStatus.present);
  int get absentCount => _count(AttendanceStatus.absent);
  int get lateCount => _count(AttendanceStatus.late);

  double get overallRate => records.isEmpty
      ? 0
      : ((presentCount + lateCount) / records.length) * 100;

  List<MonthlyAttendanceModel> get monthlyTrend {
    final grouped = <String, List<AttendanceRecordModel>>{};
    for (final r in records) {
      final key = '${r.date.year}-${r.date.month.toString().padLeft(2, '0')}';
      grouped.putIfAbsent(key, () => []).add(r);
    }
    final keys = grouped.keys.toList()..sort();
    return keys.map((k) {
      final list = grouped[k]!;
      final attended =
          list.where((r) => r.status != AttendanceStatus.absent).length;
      final parts = k.split('-');
      return MonthlyAttendanceModel(
        month: DateTime(int.parse(parts[0]), int.parse(parts[1])),
        rate: attended / list.length * 100,
      );
    }).toList();
  }
}