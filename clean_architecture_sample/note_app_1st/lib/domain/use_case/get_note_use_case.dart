import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/repository/note_repositoty.dart';

class GetNoteUseCase {
  final NoteRepository repository;

  GetNoteUseCase(this.repository);

  Future<Note?> call(int id) async {
    return await repository.getNoteById(id);
  }
}