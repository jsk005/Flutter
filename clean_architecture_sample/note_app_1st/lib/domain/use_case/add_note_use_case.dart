import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/repository/note_repositoty.dart';

class AddNoteUseCase {
  final NoteRepository repository;

  AddNoteUseCase(this.repository);

  Future<void> call(Note note) async {
    await repository.insertNote(note);
  }
}