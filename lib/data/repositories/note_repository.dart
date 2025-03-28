import 'package:introspection_note_mvp/constant/constant.dart';
import 'package:introspection_note_mvp/data/db/database_helper.dart';
import 'package:introspection_note_mvp/data/models/introspection_note.dart';
import 'package:sqflite/sqflite.dart';

class NoteRepository {
  Future<List<IntrospectionNote>> fetchNotes() async => [];
  Future<void> add(IntrospectionNote note) async {}
  Future<void> update(IntrospectionNote note) async {}
  Future<void> delete(IntrospectionNote note) async {}
}

class NoteRepositoryImpl extends NoteRepository {
  final DatabaseHelper dbHelper;

  NoteRepositoryImpl({DatabaseHelper? dbHelper})
    : dbHelper = dbHelper ?? DatabaseHelper.instance;

  @override
  Future<List<IntrospectionNote>> fetchNotes() async {
    final db = await dbHelper.database;
    final maps = await db.query(
      DatabaseHelper.table,
      orderBy: '${DatabaseHelper.columnDate} DESC',
    );

    return List.generate(maps.length, (i) {
      return IntrospectionNote.fromJson(maps[i]);
    });
  }

  @override
  Future<void> add(IntrospectionNote note) async {
    final db = await dbHelper.database;
    await db.insert(
      DatabaseHelper.table,
      note.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> update(IntrospectionNote note) async {
    final db = await dbHelper.database;
    await db.update(
      DatabaseHelper.table,
      note.toJson(),
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [note.id],
    );
  }

  @override
  Future<void> delete(IntrospectionNote note) async {
    final db = await dbHelper.database;
    await db.delete(
      DatabaseHelper.table,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [note.id],
    );
  }

  // 特定のIDのノートを取得
  Future<IntrospectionNote?> getNoteById(String id) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      DatabaseHelper.table,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null;
    }
    return IntrospectionNote.fromJson(maps.first);
  }
}

class NoteRepositoryFakeImpl extends NoteRepository {
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
    await Future.delayed(const Duration(seconds: 1));
    final index = notes.indexWhere((element) => element.id == note.id);
    notes[index] = note;
  }

  @override
  Future<void> delete(IntrospectionNote note) async {
    await Future.delayed(const Duration(seconds: 1));
    notes.removeWhere((element) => element.id == note.id);
  }
}
