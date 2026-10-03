import 'dart:developer';
import 'dart:io';

import 'package:edura/presentation/role/student/tabs/lessons/data/data_source/student_home_work/student_home_work_remote_data_source.dart';
import 'package:edura/presentation/role/student/tabs/lessons/data/model/student_home_work/homework_submission_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/error/app_error.dart';

@LazySingleton(as: StudentHomeWorkRemoteDataSource)
class StudentHomeWorkSupabaseDataSource
    implements StudentHomeWorkRemoteDataSource {
  final supabase = Supabase.instance.client;
  static const _bucket = 'homework-submissions';
  //static const _signedUrlSeconds = 60 * 60 * 6;

  @override
  Future<HomeworkSubmissionModel?> getMySubmission(
    String homeworkId,
    String studentId,
  ) async {
    try {
      final rows = await supabase
          .from('homework_submissions')
          .select()
          .eq('homework_id', homeworkId)
          .eq('student_id', studentId)
          .limit(1);

      if ((rows as List).isEmpty) {
        return null;
      }
      return HomeworkSubmissionModel.fromJson(rows.first);
    } catch (e) {
      throw ServerError();
    }
  }

  @override
  Future<List<HomeworkSubmissionModel>> getSubmissionsForHomework(
    String homeworkId,
    String studentId,
  ) async {
    try {
      final rows = await supabase
          .from('homework_submissions')
          .select()
          .eq('homework_id', homeworkId)
          .eq('student_id', studentId)
          .order('submitted_at', ascending: false);

      return (rows as List)
          .map((e) => HomeworkSubmissionModel.fromJson(e))
          .toList();
    } catch (e) {
      throw ServerError();
    }
  }

  @override
  Future<HomeworkSubmissionModel> submit({
    required String homeworkId,
    required File file,
    DateTime? dueDate,
    required String studentId,
  }) async {
    try {
      final fileName = file.path.split('/').last;
      final storagePath = '$homeworkId/$studentId/$fileName';

      await supabase.storage
          .from(_bucket)
          .upload(
            storagePath,
            file,
            fileOptions: const FileOptions(upsert: true),
          );

      final status = (dueDate != null && DateTime.now().isAfter(dueDate))
          ? 'late'
          : 'submitted';

      final row = await supabase
          .from('homework_submissions')
          .upsert({
            'homework_id': homeworkId,
            'student_id': studentId,
            'role': 'student',
            'file_name': fileName,
            'file_url': storagePath,
            'submitted_at': DateTime.now().toIso8601String(),
            'status': status,
            'updated_at': DateTime.now().toIso8601String(),
          }, onConflict: 'homework_id,student_id')
          .select()
          .single();

      return HomeworkSubmissionModel.fromJson(row);
    } catch (e) {
      log('Error submitting homework: $e');
      throw ServerError();
    }
  }
}
