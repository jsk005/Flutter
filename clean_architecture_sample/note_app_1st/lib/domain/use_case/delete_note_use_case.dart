import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/repository/note_repositoty.dart';

class DeleteNoteUseCase {
  final NoteRepository repository;

  DeleteNoteUseCase(this.repository);

  Future<void> call(Note note) async {
    await repository.deleteNote(note);
  }
}