import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/notes/section/folder_notes_screen.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/notes/section/note_editor_screen.dart';
import 'package:edura/presentation/role/student/tabs/profile/section/notes/section/note_folder_card.dart';
import 'package:flutter/material.dart';


import '../../../../../../../core/model/note_model.dart';
import '../../../../../../../l10n/app_localizations.dart';
import 'section/recent_note_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String _searchQuery = '';
  late List<NoteModel> _allNotes;

  @override
  void initState() {
    super.initState();
    _allNotes = List<NoteModel>.from(DummyNotesData.notes);
  }

  List<NoteModel> get _filteredNotes {
    if (_searchQuery.isEmpty) return _allNotes;
    return _allNotes
        .where((n) => n.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  Future<void> _createNewNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NoteEditorScreen()),
    );
    if (result is NoteModel) {
      setState(() => _allNotes.insert(0, result));
    }
  }

  Future<void> _openNote(NoteModel note) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NoteEditorScreen(existingNote: note)),
    );
    if (result is NoteModel) {
      setState(() {
        final index = _allNotes.indexWhere((n) => n.id == result.id);
        if (index >= 0) _allNotes[index] = result;
      });
    } else if (result == 'deleted') {
      setState(() => _allNotes.removeWhere((n) => n.id == note.id));
    }
  }

  void _openFolder(dynamic folder) {
    final folderNotes =
    _allNotes.where((n) => n.folderId == folder.id).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FolderNotesScreen(folder: folder, notes: folderNotes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final notes = _filteredNotes;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.notes,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: _createNewNote,
              icon: const Icon(Icons.add, size: 18, color: Colors.white),
              label: Text(l10.newNote, style: const TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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
              CustomTextFormedField(
                hintText: l10.searchNotes,
                prefix: const Icon(Icons.search, color: ColorManager.gray),

                onChanged: (value) => setState(() => _searchQuery = value),
              ),
              const SizedBox(height: 20),

              CustomText(
                text: l10.folders,
                style: TextStyle(
                  color: ColorManager.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: DummyNotesData.folders.map((folder) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: NoteFolderCard(
                        folder: folder,
                        onTap: () => _openFolder(folder),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              CustomText(
                text: l10.recentNotes,
                style: TextStyle(
                  color: ColorManager.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              if (notes.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: CustomText(
                      text: l10.noNotesFound,
                      style: TextStyle(
                        color: ColorManager.black.withValues(alpha: 0.5),
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              else
                ...notes.map((note) => RecentNoteCard(
                  note: note,
                  onTap: () => _openNote(note),
                )),
            ],
          ),
        ),
      ),
    );
  }
}