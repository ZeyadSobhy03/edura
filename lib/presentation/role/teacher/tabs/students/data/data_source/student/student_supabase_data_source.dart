import 'package:edura/core/error/app_error.dart';
import 'package:edura/presentation/role/teacher/tabs/students/data/data_source/student/student_remote_data_source.dart';
import 'package:edura/presentation/role/teacher/tabs/students/data/model/student_attendance_history.dart';
import 'package:edura/presentation/role/teacher/tabs/students/data/model/student_detail_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: StudentRemoteDataSource)
class StudentSupabaseDataSource implements StudentRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<StudentModel>> getStudents() async {
    try {
      final response = await supabase.from('students').select();

      return response.map((json) => StudentModel.fromJson(json)).toList();
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }

  @override
  Future<StudentModel> getStudentDetails({required String studentId}) async {
    try {
      final response = await supabase
          .from('students')
          .select('''
          *,
          student_attendance (*)
        ''')
          .eq('id', studentId)
          .single();

      final lessonsResponse = await supabase.rpc(
        'student_lessons_with_progress',
        params: {'p_student_id': studentId},
      );

      final lessonProgress = (lessonsResponse as List)
          .map((e) => LessonProgress.fromJson(e as Map<String, dynamic>))
          .toList();
      final examsResponse = await supabase.rpc(
        'student_exam_results',
        params: {'p_student_id': studentId},
      );

      final examResults = (examsResponse as List)
          .map((e) => ExamResult.fromJson(e as Map<String, dynamic>))
          .toList();
      final statsResponse = await supabase.rpc(
        'student_header_stats',
        params: {'p_student_id': studentId},
      );

      final stats = (statsResponse as Map<String, dynamic>?) ?? {};
      return StudentModel.fromDetailsJson(
        {...response, ...stats},
        lessonProgress: lessonProgress,
        examResults: examResults,
      );
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }

  @override
  Future<void> markAttendance({
    required String lessonId,
    required DateTime date,
    required List<Map<String, String>> entries,
    required String teacherId,
  }) async {
    try {
      final rows = entries
          .map(
            (e) => {
              'student_id': e['studentId'],
              'lesson_id': lessonId,
              'teacher_id': teacherId,
              'date': date.toIso8601String().split('T').first,
              'status': e['status'],
            },
          )
          .toList();

      await supabase
          .from('student_attendance')
          .upsert(rows, onConflict: 'student_id,lesson_id,date');
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }

  @override
  Future<Map<String, String>> getAttendanceForLesson({
    required String lessonId,
    required DateTime date,
  }) async {
    try {
      final dateStr = date.toIso8601String().split('T').first;
      final response = await supabase
          .from('student_attendance')
          .select('student_id, status')
          .eq('lesson_id', lessonId)
          .eq('date', dateStr);

      return {
        for (final row in response)
          row['student_id'] as String: row['status'] as String,
      };
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }

  @override
  Future<List<StudentAttendanceHistory>> getAttendanceHistoryForGrade({
    required String grade,
  }) async {
    try {
      final teacherId = supabase.auth.currentUser!.id;
      final response = await supabase
          .from('students')
          .select('id, name, student_attendance(date, status)')
          .eq('grade', grade)
          .eq('teacher_id', teacherId);

      return response
          .map((json) => StudentAttendanceHistory.fromJson(json))
          .toList();
    } on AppError {
      rethrow;
    } catch (e) {
      throw ServerError();
    }
  }
}
