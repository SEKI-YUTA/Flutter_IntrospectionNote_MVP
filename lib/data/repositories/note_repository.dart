import 'package:introspection_note_mvp/constant/constant.dart';
import 'package:introspection_note_mvp/data/models/introspection_note.dart';

class NoteRepository {
  Future<List<IntrospectionNote>> fetchNotes() async => [];
}

class NoteRepositoryImpl extends NoteRepository {
  @override
  Future<List<IntrospectionNote>> fetchNotes() async {
    await Future.delayed(const Duration(seconds: 1));
    return notes;
  }
}
