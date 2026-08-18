import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/model/attendance_taking_model.dart';
import '../../../../../../../l10n/app_localizations.dart';
import 'section/attendance_summary_stat.dart';
import 'section/student_attendance_row.dart';

class TakeAttendanceScreen extends StatefulWidget {
  const TakeAttendanceScreen({super.key});

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  late List<StudentAttendanceModel> _students;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _students = List<StudentAttendanceModel>.from(DummyAttendanceTakingData.students);
  }

  int _countByStatus(AttendanceMark mark) =>
      _students.where((s) => s.status == mark).length;

  void _cycleStatus(StudentAttendanceModel student) {
    setState(() {
      switch (student.status) {
        case AttendanceMark.present:
          student.status = AttendanceMark.absent;
          break;
        case AttendanceMark.absent:
          student.status = AttendanceMark.late;
          break;
        case AttendanceMark.late:
          student.status = AttendanceMark.present;
          break;
      }
    });
  }

  Future<void> _saveAttendance() async {
    setState(() => _isSaving = true);

    // TODO: batch-upsert into Supabase `attendance_records`
    // (student_id, date: today, status) for each entry in _students.
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;
    setState(() => _isSaving = false);

    final l10 = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10.attendanceSavedSuccessfully)),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.attendance,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AttendanceSummaryStat(
                            count: _countByStatus(AttendanceMark.present),
                            label: l10.present,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AttendanceSummaryStat(
                            count: _countByStatus(AttendanceMark.absent),
                            label: l10.absent,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AttendanceSummaryStat(
                            count: _countByStatus(AttendanceMark.late),
                            label: l10.late,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    ..._students.map((student) {
                      return StudentAttendanceRow(
                        student: student,
                        onStatusTap: () => _cycleStatus(student),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // Save button pinned at the bottom
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveAttendance,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : Text(
                    l10.saveAttendanceCount(_students.length),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}