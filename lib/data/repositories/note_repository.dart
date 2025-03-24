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
    notes.sort((a, b) => b.date.compareTo(a.date));
    return notes;
  }

  @override
  Future<void> add(IntrospectionNote note) async {
    await Future.delayed(const Duration(seconds: 1));
    notes.add(note);
  }

  @override
  Future<void> update(IntrospectionNote note) async {
    print("update: ${note}");
    await Future.delayed(const Duration(seconds: 1));
    final index = notes.indexWhere((element) => element.id == note.id);
    print("index: $index");
    notes[index] = note;
  }

  @override
  Future<void> delete(IntrospectionNote note) async {
    await Future.delayed(const Duration(seconds: 1));
    notes.removeWhere((element) => element.id == note.id);
  }
}
