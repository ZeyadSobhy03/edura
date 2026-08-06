import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/notes/section/recent_note_card.dart';
import 'package:flutter/material.dart';


import '../../../../../../../../core/model/note_folder_model.dart';
import '../../../../../../../../core/model/note_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import 'note_editor_screen.dart';

class FolderNotesScreen extends StatefulWidget {
  const FolderNotesScreen({
    super.key,
    required this.folder,
    required this.notes,
  });

  final NoteFolderModel folder;
  final List<NoteModel> notes; // pre-filtered notes belonging to this folder

  @override
  State<FolderNotesScreen> createState() => _FolderNotesScreenState();
}

class _FolderNotesScreenState extends State<FolderNotesScreen> {
  late List<NoteModel> _notes;

  @override
  void initState() {
    super.initState();
    _notes = List<NoteModel>.from(widget.notes);
  }

  Future<void> _openNote(NoteModel? note) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NoteEditorScreen(
          existingNote: note,
          folderId: widget.folder.id,
        ),
      ),
    );

    if (result is NoteModel) {
      setState(() {
        final index = _notes.indexWhere((n) => n.id == result.id);
        if (index >= 0) {
          _notes[index] = result; // edited
        } else {
          _notes.insert(0, result); // newly created
        }
      });
    } else if (result == 'deleted' && note != null) {
      setState(() => _notes.removeWhere((n) => n.id == note.id));
    }
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
          text: widget.folder.name,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: ColorManager.primary),
            onPressed: () => _openNote(null),
          ),
        ],
      ),
      body: SafeArea(
        child: _notes.isEmpty
            ? Center(
          child: CustomText(
            text: l10.noNotesFound,
            style: TextStyle(
              color: ColorManager.black.withValues(alpha: 0.5),
              fontSize: 14,
            ),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _notes.length,
          itemBuilder: (context, index) {
            final note = _notes[index];
            return RecentNoteCard(
              note: note,
              onTap: () => _openNote(note),
            );
          },
        ),
      ),
    );
  }
}