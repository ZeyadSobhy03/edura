import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view_model/student_notes/student_notes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../../l10n/app_localizations.dart';
import '../../../../data/model/student_notes/note_model.dart';
import 'section/recent_note_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String _searchQuery = '';
  List<NoteModel> _allNotes = [];
  String? studentId;

  @override
  void initState() {
    super.initState();
    studentId = Supabase.instance.client.auth.currentUser?.id;
    if (studentId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushNamed(context, RouteManger.loginRoute);
        }
      });
      return;
    }
    context.read<StudentNotesCubit>().getAllNotes(studentId: studentId!);
  }

  List<NoteModel> get _filteredNotes {
    if (_searchQuery.isEmpty) return _allNotes;
    return _allNotes
        .where(
          (n) => n.title.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  Future<void> _createNewNote() async {
    final result = await Navigator.pushNamed(
      context,
      RouteManger.noteEditorScreen,
    );
    if (result is NoteModel && mounted) {
      setState(() => _allNotes.insert(0, result));
    }
  }

  Future<void> _openNote(NoteModel note) async {
    final result = await Navigator.pushNamed(
      context,
      RouteManger.noteEditorScreen,
      arguments: note,
    );
    if (!mounted) return;
    if (result is NoteModel) {
      setState(() {
        final index = _allNotes.indexWhere((n) => n.id == result.id);
        if (index >= 0) _allNotes[index] = result;
      });
    } else if (result == 'deleted') {
      setState(() => _allNotes.removeWhere((n) => n.id == note.id));
    }
  }

  Future<void> _deleteNote(String noteId) async {
    try {
      await context.read<StudentNotesCubit>().deleteNote(
        noteId: noteId,
        studentId: studentId!,
      );
      if (!mounted) return;
      Fluttertoast.showToast(
        backgroundColor: ColorManager.green,
        gravity: ToastGravity.BOTTOM,
        textColor: ColorManager.white,
        msg: AppLocalizations.of(context)!.noteDeletedSuccessfully,
      );

      setState(() => _allNotes.removeWhere((n) => n.id == noteId));
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(
          backgroundColor: ColorManager.red,
          gravity: ToastGravity.BOTTOM,
          textColor: ColorManager.white,
          msg: AppLocalizations.of(context)!.errorDeletingNote,
        );
      }
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
              label: Text(
                l10.newNote,
                style: const TextStyle(color: Colors.white),
              ),
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
                text: l10.recentNotes,
                style: TextStyle(
                  color: ColorManager.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              BlocBuilder<StudentNotesCubit, StudentNotesState>(
                builder: (context, state) {
                  if (state is StudentNotesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primary,
                        strokeWidth: 2,
                      ),
                    );
                  } else if (state is StudentNotesFailure) {
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
                  } else if (state is StudentNotesLoaded) {
                    _allNotes = state.notes;
                    final notes = _filteredNotes;

                    if (notes.isEmpty) {
                      return Padding(
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
                      );
                    }
                    return Column(
                      children: notes
                          .map(
                            (note) => RecentNoteCard(
                              onDelete: () => _deleteNote(note.id),
                              onEdit: () {},
                              note: note,
                              onTap: () => _openNote(note),
                            ),
                          )
                          .toList(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
