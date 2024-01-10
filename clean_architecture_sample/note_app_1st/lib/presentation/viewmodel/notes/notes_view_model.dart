import 'package:flutter/material.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/repository/note_repositoty.dart';
import 'package:note_app/presentation/viewmodel/notes/notes_event.dart';
import 'package:note_app/presentation/viewmodel/notes/notes_state.dart';

class NotesViewModel extends ChangeNotifier {
  final NoteRepository repository;

  NotesState _state = NotesState(notes: []);
  NotesState get state => _state;

  // List<Note> _notes = [];
  // UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);

  Note? _recentlyDeleteNote;

  NotesViewModel(this.repository){
   _loadNotes();
  }

  void onEvent(NotesEvent event) {
    event.when(
      loadNotes: _loadNotes,
      deleteNote: _deleteNote,
      restoreNote: _restoreNote,
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await repository.getNotes();
    _state = state.copyWith(notes: notes);
    notifyListeners();
  }

  Future<void> _deleteNote(Note note) async {
    await repository.deleteNote(note);
    _recentlyDeleteNote = note;
    await _loadNotes();
  }

  Future<void> _restoreNote() async {
    if(_recentlyDeleteNote != null){
      await repository.insertNote(_recentlyDeleteNote!);
      _recentlyDeleteNote = null;
    }
  }

}
