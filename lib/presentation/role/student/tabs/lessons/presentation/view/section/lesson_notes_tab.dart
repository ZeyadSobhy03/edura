import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_elevated_button.dart';
import 'package:edura/core/widgets/custom_label.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/presentation/role/student/tabs/profile/data/model/student_notes/note_model.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view_model/student_notes/student_notes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../profile/presentation/view/section/notes/section/recent_note_card.dart';

class LessonNotesTab extends StatefulWidget {
  const LessonNotesTab({
    super.key,
    this.initialNote,
    this.lessonId,
    this.subject,
  });

  final String? initialNote;
  final String? lessonId;
  final String? subject;

  @override
  State<LessonNotesTab> createState() => _LessonNotesTabState();
}

class _LessonNotesTabState extends State<LessonNotesTab> {
  String? studentId;

  // null = creating a new note, not null = editing an existing note
  String? _editingNoteId;
  String _originalTitle = '';
  String _originalContent = '';

  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  late final TextEditingController titleController = TextEditingController();
  late final TextEditingController contentController = TextEditingController(
    text: widget.initialNote,
  );

  @override
  void initState() {
    super.initState();
    studentId = Supabase.instance.client.auth.currentUser?.id;
    if (studentId != null && widget.lessonId != null) {
      context.read<StudentNotesCubit>().getNotesOfLesson(
        lessonId: widget.lessonId ?? '',
        studentId: studentId!,
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote(AppLocalizations l10) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (widget.lessonId == null || studentId == null) return;

    setState(() => _isSaving = true);
    try {
      await context.read<StudentNotesCubit>().createNote(
        subject: widget.subject ?? '',
        studentId: studentId!,
        title: titleController.text.trim(),
        content: contentController.text.trim(),
        lessonId: widget.lessonId!,
      );

      if (!mounted) return;

      titleController.clear();
      contentController.clear();
      _formKey.currentState?.reset();

      Fluttertoast.showToast(
        msg: l10.noteSavedSuccessfully,
        backgroundColor: ColorManager.green,
        textColor: ColorManager.white,
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _startEdit(NoteModel note) {
    setState(() {
      _editingNoteId = note.id;
      _originalTitle = note.title.trim();
      _originalContent = note.content.trim();
      titleController.text = note.title;
      contentController.text = note.content;
    });
  }

  void _cancelEdit() {
    setState(() => _editingNoteId = null);
    titleController.clear();
    contentController.clear();
    _formKey.currentState?.reset();
  }

  Future<void> _editNote(AppLocalizations l10) async {
    final noteId = _editingNoteId;
    if (noteId == null) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (widget.lessonId == null || studentId == null) return;

    final newTitle = titleController.text.trim();
    final newContent = contentController.text.trim();

    // nothing changed -> just leave edit mode, no update request
    if (newTitle == _originalTitle && newContent == _originalContent) {
      _cancelEdit();
      return;
    }

    setState(() => _isSaving = true);
    try {
      await context.read<StudentNotesCubit>().updateNote(
        noteId: noteId,
        studentId: studentId!,
        title: newTitle,
        content: newContent,
      );

      if (!mounted) return;

      _cancelEdit();

      Fluttertoast.showToast(
        msg: l10.noteUpdatedSuccessfully,
        backgroundColor: ColorManager.green,
        textColor: ColorManager.white,
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _deleteNote(AppLocalizations l10, String noteId) async {
    if (widget.lessonId == null || studentId == null) return;

    setState(() => _isSaving = true);
    try {
      await context.read<StudentNotesCubit>().deleteNote(
        noteId: noteId,
        studentId: studentId!,
      );

      if (!mounted) return;

      // if the deleted note was being edited, clear the form
      if (_editingNoteId == noteId) _cancelEdit();

      Fluttertoast.showToast(
        msg: l10.noteDeletedSuccessfully,
        backgroundColor: ColorManager.green,
        textColor: ColorManager.white,
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final isEditing = _editingNoteId != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
          ),
          child: CustomText(
            text: l10.personalNotesHint,
            style: const TextStyle(color: Colors.brown, fontSize: 13),
          ),
        ),
        const SizedBox(height: 12),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabel(label: l10.noteTitle),
              const SizedBox(height: 12),
              CustomTextFormedField(
                minLines: 1,
                maxLines: 2,
                hintText: l10.noteTitle,
                controller: titleController,
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? l10.noteTitleRequired
                    : null,
              ),
              const SizedBox(height: 12),
              CustomLabel(label: l10.noteContent),
              const SizedBox(height: 12),
              CustomTextFormedField(
                minLines: 4,
                maxLines: 8,
                hintText: l10.noteContentHint,
                controller: contentController,
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? l10.noteContentRequired
                    : null,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        CustomElevatedButton(
          text: isEditing ? l10.update : l10.save,
          onPressed: _isSaving
              ? null
              : () => isEditing ? _editNote(l10) : _saveNote(l10),
        ),
        if (isEditing) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: _isSaving ? null : _cancelEdit,
              child: Text(l10.cancel),
            ),
          ),
        ],
        const SizedBox(height: 12),
        BlocBuilder<StudentNotesCubit, StudentNotesState>(
          builder: (context, state) {
            if (state is StudentNotesLoading || state is StudentNotesInitial) {
              return Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            }
            if (state is StudentNotesFailure) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(
                    color: ColorManager.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            if (state is StudentNotesLoaded) {
              final notes = state.notes;
              if (notes.isEmpty) {
                return Center(
                  child: Text(
                    l10.noNotesFound,
                    style: const TextStyle(
                      color: ColorManager.gray,
                      fontSize: 14,
                    ),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: l10.recentNotes,
                    style: const TextStyle(
                      color: ColorManager.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: notes.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return RecentNoteCard(
                        note: note,
                        onDelete: () => _deleteNote(l10, note.id),
                        onEdit: () => _startEdit(note),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteManger.noteEditorScreen,
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
