import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/model/note_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({
    super.key,
    this.existingNote,
    this.folderId,
    this.subjectOptions = const ['Mathematics', 'Physics', 'General'],
  });

  final NoteModel? existingNote;
  final String? folderId;
  final List<String> subjectOptions;

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late String _selectedSubject;

  bool get _isEditing => widget.existingNote != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.existingNote?.title ?? '',
    );
    _contentController = TextEditingController(
      text: widget.existingNote?.preview ?? '',
    );
    _selectedSubject =
        widget.existingNote?.subject ?? widget.subjectOptions.first;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _save() {
    final l10 = AppLocalizations.of(context)!;
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10.noteTitleRequired)));
      return;
    }

    final note = NoteModel(
      id:
          widget.existingNote?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      subject: _selectedSubject,
      preview: _contentController.text.trim(),
      date: DateTime.now(),
      folderId: widget.folderId ?? widget.existingNote?.folderId ?? '',
    );

    Navigator.pop(context, note);
  }

  void _delete() {
    // TODO: delete widget.existingNote from Supabase
    Navigator.pop(context, 'deleted');
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

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
              onPressed: _delete,
            ),
          TextButton(
            onPressed: _save,
            child: Text(
              l10.save,
              style: TextStyle(
                color: ColorManager.primary,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title field
              TextField(
                controller: _titleController,
                style: TextStyle(
                  color: ColorManager.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: l10.noteTitleHint,
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 8),

              // Subject dropdown chip selector
              Wrap(
                spacing: 8,
                children: widget.subjectOptions.map((subject) {
                  final isSelected = subject == _selectedSubject;
                  return ChoiceChip(
                    label: Text(subject),
                    selected: isSelected,
                    onSelected: (_) =>
                        setState(() => _selectedSubject = subject),
                    selectedColor: ColorManager.primary.withValues(alpha: 0.15),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? ColorManager.primary
                          : ColorManager.black,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? ColorManager.primary
                            : ColorManager.gray.withValues(alpha: 0.3),
                      ),
                    ),
                    backgroundColor: ColorManager.white,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Divider(color: ColorManager.gray.withValues(alpha: 0.2)),
              const SizedBox(height: 8),

              // Content field
              TextField(
                controller: _contentController,
                maxLines: null,
                minLines: 12,
                style: TextStyle(
                  color: ColorManager.black.withValues(alpha: 0.85),
                  fontSize: 15,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  hintText: l10.noteContentHint,
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
