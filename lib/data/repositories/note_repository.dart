import 'package:introspection_note_mvp/constant/constant.dart';
import 'package:introspection_note_mvp/data/models/introspection_note.dart';

class NoteRepository {
  Future<List<IntrospectionNote>> fetchNotes() async => [];
  Future<void> add(IntrospectionNote note) async {}
  Future<void> update(IntrospectionNote note) async {}
  Future<void> delete(IntrospectionNote note) async {}
}

class NoteRepositoryImpl extends NoteRepository {
  @override
  Future<List<IntrospectionNote>> fetchNotes() async {
    await Future.delayed(const Duration(seconds: 1));
    return notes;
  }

  Future<void> add(IntrospectionNote note) async {
    await Future.delayed(const Duration(seconds: 1));
    notes.add(note);
  }

  Future<void> update(IntrospectionNote note) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = notes.indexWhere((element) => element.id == note.id);
    notes[index] = note;
  }

  Future<void> delete(IntrospectionNote note) async {
    await Future.delayed(const Duration(seconds: 1));
    notes.removeWhere((element) => element.id == note.id);
  }
}
