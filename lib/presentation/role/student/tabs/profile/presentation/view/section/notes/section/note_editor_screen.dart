import 'package:edura/core/localization/error_messages.dart';
import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view_model/lessons/teacher_lessons_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../../../core/widgets/custom_chip.dart';
import '../../../../../../../../../../l10n/app_localizations.dart';
import '../../../../../data/model/student_notes/note_model.dart';
import '../../../../view_model/student_notes/student_notes_view_model.dart';


class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key, this.existingNote});

  final NoteModel? existingNote;

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<LessonModel> _lessons = [];

  String? studentId;
  String? lessonTitle;
  String? studentGrade;
  String? lessonId;
  bool isSelected = false;
  String? selectedLessonId;
  bool _isDeletingNote = false;

  bool get _isEditing => widget.existingNote != null;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(
      text: widget.existingNote?.title ?? '',
    );
    _contentController = TextEditingController(
      text: widget.existingNote?.content ?? '',
    );
    selectedLessonId = widget.existingNote?.lessonId;

    final user = Supabase.instance.client.auth.currentUser;
    studentId = user?.id;
    studentGrade = user?.userMetadata?['grade'] as String?;

    if (studentId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, RouteManger.loginRoute);
      });
      return;
    }

    context.read<TeacherLessonsCubit>().fetchLessonByGrade(studentGrade ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (studentId == null) return;

    _isDeletingNote = false;

    context.read<StudentNotesCubit>().createNote(
      lessonId: lessonId ?? '',
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      subject: lessonTitle ?? '',
      studentId: studentId!,
    );
  }

  Future<void> _delete(String noteId) async {
    if (studentId == null) return;

    _isDeletingNote = true;

    context.read<StudentNotesCubit>().deleteNote(
      noteId: noteId,
      studentId: studentId!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return BlocConsumer<StudentNotesCubit, StudentNotesState>(
      listener: (context, state) {
        if (state is StudentNotesLoaded) {
          if (_isDeletingNote) {
            Fluttertoast.showToast(
              msg: l10.noteDeletedSuccessfully,
              backgroundColor: ColorManager.green,
              gravity: ToastGravity.BOTTOM,
              textColor: ColorManager.white,
            );
            _isDeletingNote = false;
            Navigator.pop(context, 'deleted');
          } else {
            Fluttertoast.showToast(
              msg: _isEditing
                  ? l10.noteUpdatedSuccessfully
                  : l10.noteCreatedSuccessfully,
              backgroundColor: ColorManager.green,
              gravity: ToastGravity.BOTTOM,
              textColor: ColorManager.white,
            );
            Navigator.pop(context, true);
          }
        } else if (state is StudentNotesFailure) {
          _isDeletingNote = false;
          Fluttertoast.showToast(
            msg: state.error,
            backgroundColor: ColorManager.red,
            gravity: ToastGravity.BOTTOM,
            textColor: ColorManager.white,
          );
        }
      },
      builder: (context, notesState) {
        final bool isLoading = notesState is StudentNotesLoading;

        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0,
            title: CustomText(
              text: _isEditing ? l10.editNote : l10.newNote,
              style: TextStyle(
                color: ColorManager.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              if (_isEditing)
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: isLoading
                      ? null
                      : () => _delete(widget.existingNote!.id),
                ),
              TextButton(
                onPressed: isLoading ? null : _save,
                child: Text(
                  l10.save,
                  style: TextStyle(
                    color: isLoading ? ColorManager.gray : ColorManager.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormedField(
                      hintText: l10.noteTitleHint,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10.noteTitleRequired;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: _titleController,
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<TeacherLessonsCubit, TeacherLessonsState>(
                      builder: (context, state) {
                        if (state is TeacherLessonsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.primary,
                            ),
                          );
                        }
                        if (state is TeacherLessonsFailure) {
                          return Center(
                            child: Text(
                              ErrorMessages.get(context, state.error),
                              style: const TextStyle(color: ColorManager.red),
                            ),
                          );
                        }
                        if (state is TeacherLessonsLoaded) {
                          _lessons = state.publishedLessons;
                          if (_lessons.isEmpty) {
                            return Center(
                              child: Text(
                                l10.noLessonsFound,
                                style: const TextStyle(
                                  color: ColorManager.gray,
                                ),
                              ),
                            );
                          }
                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _lessons.map((lesson) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: 8,
                                  bottom: 8,
                                ),
                                child: CustomChip(
                                  onTap: () {
                                    setState(() {
                                      selectedLessonId = lesson.id;
                                      lessonId = lesson.id;
                                      lessonTitle = lesson.title;
                                    });
                                  },
                                  isSelected: selectedLessonId == lesson.id,
                                  label:  lesson.title ,
                                ),
                              );
                            }).toList(),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 16),
                    Divider(color: ColorManager.gray.withValues(alpha: 0.2)),
                    const SizedBox(height: 8),
                    CustomTextFormedField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10.noteContentRequired;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                      hintText: l10.noteContentHint,
                      controller: _contentController,
                      maxLines: null,
                      minLines: 12,
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: ColorManager.primary
                              .withValues(alpha: 0.6),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                            : Text(
                          l10.save,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}