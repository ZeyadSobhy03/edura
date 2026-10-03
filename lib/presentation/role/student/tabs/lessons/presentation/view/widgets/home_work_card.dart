import 'dart:io';

import 'package:edura/core/DI/injection.dart';
import 'package:edura/core/extensions/date_ex.dart';
import 'package:edura/core/helper/home_work_status_style.dart';
import 'package:edura/presentation/role/student/tabs/lessons/presentation/view/widgets/build_picker_view.dart';
import 'package:edura/presentation/role/student/tabs/lessons/presentation/view/widgets/build_submitted_view.dart';
import 'package:edura/presentation/role/student/tabs/lessons/presentation/view_model/student_home_work/student_home_work_view_model.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/data/model/home_work/new_homework_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class HomeWorkCard extends StatefulWidget {
  const HomeWorkCard({super.key, this.homework});

  final NewHomeworkModel? homework;

  @override
  State<HomeWorkCard> createState() => _HomeWorkCardState();
}

class _HomeWorkCardState extends State<HomeWorkCard> {
  File? _pickedFile;
  bool _resubmitting = false;
  String? studentId;
  String? homeworkId;

  late final StudentHomeWorkCubit _cubit;

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    studentId = Supabase.instance.client.auth.currentUser?.id;
    homeworkId = widget.homework?.id;

    _cubit = getIt<StudentHomeWorkCubit>();
    if (studentId != null && homeworkId != null) {
      _cubit.getMySubmission(homeworkId!, studentId!);
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  bool get _isPdf =>
      _pickedFile != null && _pickedFile!.path.toLowerCase().endsWith('.pdf');

  String get _fileName =>
      _pickedFile?.path.split(Platform.pathSeparator).last ?? '';

  Future<void> _takePhoto() async {
    final photo = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (photo != null && mounted) {
      setState(() => _pickedFile = File(photo.path));
    }
  }

  Future<void> _pickPdf() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (result != null && result.files.single.path != null && mounted) {
      setState(() => _pickedFile = File(result.files.single.path!));
    }
  }

  Future<void> _submit() async {
    if (_pickedFile == null || studentId == null || homeworkId == null) return;

    try {
      await _cubit.submit(
        homeworkId: homeworkId!,
        studentId: studentId!,
        file: _pickedFile!,
        dueDate: widget.homework?.dueDate,
      );
      if (mounted) {
        setState(() {
          _pickedFile = null;
          _resubmitting = false;
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final homework = widget.homework;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: ColorManager.black.withValues(alpha: 0.03),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorManager.black.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomText(
                    text: homework?.title ?? '',
                    style: TextStyle(
                      color: ColorManager.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomText(
                    text: HomeWorkStatusStyle.getLabelForStatus(
                      homework?.status ?? '',
                      l10,
                    ),
                    style: TextStyle(
                      color: HomeWorkStatusStyle.getColorForStatus(
                        homework?.status ?? '',
                      ),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: CustomText(
                text: homework?.subject ?? ' ',
                style: const TextStyle(color: Colors.blue, fontSize: 11),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: ColorManager.black.withValues(alpha: 0.5),
                ),
                const SizedBox(width: 6),
                CustomText(
                  text: homework?.dueDate?.formatDate ?? '',
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.6),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            BlocConsumer<StudentHomeWorkCubit, HomeworkSubmissionState>(
              bloc: _cubit,
              listener: (context, state) {
                if (state is HomeworkSubmissionError) {
                  Fluttertoast.showToast(
                    msg: state.message,
                    backgroundColor: Colors.red,
                  );
                }
              },
              builder: (context, state) {
                if (state is HomeworkSubmissionLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ColorManager.primary,
                      ),
                    ),
                  );
                }

                final isSubmitting = state is HomeworkSubmissionSubmitting;

                final alreadySubmitted =
                    state is HomeworkSubmissionLoaded &&
                    state.submission != null;

                if (alreadySubmitted && !_resubmitting) {
                  return BuildSubmittedView(
                    onResubmit: () => setState(() => _resubmitting = true),
                  );
                }

                return BuildPickerView(
                  isSubmitting: isSubmitting,
                  hasFile: _pickedFile != null,
                  isPdf: _isPdf,
                  fileName: _fileName,
                  onTakePhoto: _takePhoto,
                  pickedFile: _pickedFile,
                  onPickPdf: _pickPdf,
                  submit: _submit,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
