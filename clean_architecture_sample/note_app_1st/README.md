### Clean Architecture Sample
Clean Architecture & DI 학습을 위해 인프런 강의를 수강하면서 들은 내용을 단계적으로 기록하기 위함이다.

### Getting Started
Clean Architecture 구조에 맞게 디렉토리명은 점차 변경해 갈 예정이다.<br/>
note app 화면 설계 및 DI 구성의 기본적인 사항이 언급되어 있다.<br/>
상태관리 라이브러리는 Provider 를 사용하고 있다.<br/>

```
// main.dart
void main() async {
  // 플랫폼 채널의 위젯 바인딩을 보장
  WidgetsFlutterBinding.ensureInitialized();

  final providers = await getProviders();

  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

// provider_setup.dart
import 'package:note_app/data/data_source/note_db_helper.dart';
import 'package:note_app/data/repository/note_repository_impl.dart';
import 'package:note_app/domain/repository/note_repositoty.dart';
import 'package:note_app/viewmodel/add_edit_note/add_edit_note_view_model.dart';
import 'package:note_app/viewmodel/notes/notes_view_model.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';

Future<List<SingleChildWidget>> getProviders() async {
  Database database = await openDatabase(
    'notes_db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER, timestamp INTEGER)');
    },
  );

  NoteDbHelper noteDbHelper = NoteDbHelper(database);
  NoteRepository repository = NoteRepositoryImpl(db: noteDbHelper);
  NotesViewModel notesViewModel = NotesViewModel(repository);
  AddEditNoteViewModel addEditNoteViewModel = AddEditNoteViewModel(repository);

  return [
    ChangeNotifierProvider(create: (_) => notesViewModel),
    ChangeNotifierProvider(create: (_) => addEditNoteViewModel),
  ];
}
```

