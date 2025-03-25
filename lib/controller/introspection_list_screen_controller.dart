import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introspection_note_mvp/data/models/introspection_note.dart';
import 'package:introspection_note_mvp/data/repositories/note_repository.dart';

class IntrospectionListScreenController extends GetxController {
  final NoteRepository repository;
  IntrospectionListScreenController({required this.repository});

  final _notes = <IntrospectionNote>[].obs;
  final _filteredNotes = <IntrospectionNote>[].obs;
  final _isLoading = true.obs;
  final _viewMode = ViewMode.List.obs;
  final _selectedDate = DateTime.now().obs;
  final Rx<IntrospectionNote?> _manipulatingNote = Rx<IntrospectionNote?>(null);
  List<IntrospectionNote> get notes => _notes.toList();
  List<IntrospectionNote> get filteredNotes => _filteredNotes.toList();
  bool get isLoading => _isLoading.value;
  ViewMode get viewMode => _viewMode.value;
  IntrospectionNote? get manipulatingNote => _manipulatingNote.value;
  DateTime get selectedDate => _selectedDate.value;

  @override
  void onInit() {
    super.onInit();
    readNotes();
  }

  Future<void> readNotes() async {
    _isLoading.value = true;
    try {
      final notes = await repository.fetchNotes();
      _notes.clear();
      _notes.addAll(notes);
      filterNotesByDate(_selectedDate.value);
    } catch (e) {
      e.printError();
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  void navigateToSettingsScreen() {
    Get.toNamed("/settings");
  }

  Future<void> navigateToCreateIntrospectionScreen() async {
    final result = await Get.toNamed("/create_introspection");
    if (result != null) {
      await readNotes();
    }
  }

  Future<void> edit(IntrospectionNote note) async {
    var mapData = note.toJson();
    final result = await Get.toNamed(
      "/create_introspection",
      arguments: {'introspection': mapData},
    );
    if (result != null) {
      await readNotes();
    }
  }

  Future<void> delete(IntrospectionNote note) async {
    Get.dialog(
      AlertDialog(
        title: Text("確認"),
        content: Text("本当に削除してもよろしいですか？"),
        actions: [
          TextButton(child: Text("キャンセル"), onPressed: () => Get.back()),
          TextButton(
            child: Text("削除"),
            onPressed: () async {
              _manipulatingNote.value = note;
              try {
                final request = repository.delete(note);
                Get.back(closeOverlays: true);
                await request;
                _notes.remove(note);
                Get.snackbar("完了", "項目が削除されました");
              } catch (e) {
                e.printError();
                Get.snackbar("エラー", "削除に失敗しました");
              } finally {
                update();
              }
              _manipulatingNote.value = null;
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void changeViewMode(ViewMode mode) {
    _viewMode.value = mode;
    if (mode == ViewMode.Calendar) {
      filterNotesByDate(_selectedDate.value);
    }
  }

  void changeSelectedDate(DateTime date) {
    _selectedDate.value = date;
    filterNotesByDate(date);
    update();
  }

  void filterNotesByDate(DateTime date) {
    _filteredNotes.clear();
    _filteredNotes.addAll(
      _notes.where((note) {
        final noteDate = note.date;
        return noteDate.year == date.year &&
            noteDate.month == date.month &&
            noteDate.day == date.day;
      }),
    );
    update();
  }
}

enum ViewMode { List, Calendar }
