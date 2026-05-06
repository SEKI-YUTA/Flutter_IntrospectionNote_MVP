import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introspection_note_mvp/data/models/introspection_note.dart';
import 'package:introspection_note_mvp/data/repositories/note_repository.dart';

class IntrospectionListScreenController extends GetxController {
  IntrospectionListScreenController({required this.repository});
  final NoteRepository repository;

  final _notes = <IntrospectionNote>[].obs;
  final _filteredNotes = <IntrospectionNote>[].obs;
  final _isLoading = true.obs;
  final _isMoreLoading = false.obs;
  final _hasMore = true.obs;
  final _viewMode = ViewMode.list.obs;
  final _selectedDate = DateTime.now().obs;
  final Rx<IntrospectionNote?> _manipulatingNote = Rx<IntrospectionNote?>(null);

  final ScrollController scrollController = ScrollController();
  int _currentOffset = 0;
  static const int _pageSize = 30;

  List<IntrospectionNote> get notes => _notes.toList();
  List<IntrospectionNote> get filteredNotes => _filteredNotes.toList();
  bool get isLoading => _isLoading.value;
  bool get isMoreLoading => _isMoreLoading.value;
  bool get hasMore => _hasMore.value;
  ViewMode get viewMode => _viewMode.value;
  IntrospectionNote? get manipulatingNote => _manipulatingNote.value;
  DateTime get selectedDate => _selectedDate.value;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    readNotes();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (!scrollController.hasClients ||
        _viewMode.value != ViewMode.list ||
        _isLoading.value ||
        _isMoreLoading.value ||
        !_hasMore.value) {
      return;
    }

    try {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        loadMore();
      }
    } catch (e) {
      // エラー無視
    }
  }

  Future<void> readNotes() async {
    _isLoading.value = true;
    _isMoreLoading.value = false;
    _currentOffset = 0;
    _hasMore.value = true;
    try {
      final notes = await repository.fetchNotes(
        limit: _pageSize,
        offset: _currentOffset,
      );
      _notes.assignAll(notes);
      _currentOffset += notes.length;
      if (notes.length < _pageSize) {
        _hasMore.value = false;
      }
      filterNotesByDate(_selectedDate.value);
    } catch (e) {
      e.printError();
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  Future<void> loadMore() async {
    if (_isMoreLoading.value || !_hasMore.value) return;

    _isMoreLoading.value = true;
    update();
    try {
      final notes = await repository.fetchNotes(
        limit: _pageSize,
        offset: _currentOffset,
      );
      if (notes.isEmpty) {
        _hasMore.value = false;
      } else {
        _notes.addAll(notes);
        _currentOffset += notes.length;
        if (notes.length < _pageSize) {
          _hasMore.value = false;
        }
      }
      filterNotesByDate(_selectedDate.value);
    } catch (e) {
      e.printError();
    } finally {
      _isMoreLoading.value = false;
      update();
    }
  }

  void navigateToSettingsScreen() {
    Get.toNamed('/settings');
  }

  Future<void> navigateToCreateIntrospectionScreen() async {
    final result = await Get.toNamed('/create_introspection');
    if (result != null) {
      await readNotes();
    }
  }

  Future<void> edit(IntrospectionNote note) async {
    final mapData = note.toJson();
    final result = await Get.toNamed(
      '/create_introspection',
      arguments: {'introspection': mapData},
    );
    if (result != null) {
      await readNotes();
    }
  }

  Future<void> delete(IntrospectionNote note) async {
    Get.dialog(
      AlertDialog(
        title: const Text('確認'),
        content: const Text('本当に削除してもよろしいですか？'),
        actions: [
          TextButton(child: const Text('キャンセル'), onPressed: () => Get.back()),
          TextButton(
            child: const Text('削除'),
            onPressed: () async {
              _manipulatingNote.value = note;
              try {
                final request = repository.delete(note);
                Get.back(closeOverlays: true);
                await request;
                _notes.remove(note);
                Get.snackbar('完了', '項目が削除されました');
              } catch (e) {
                e.printError();
                Get.snackbar('エラー', '削除に失敗しました');
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
    if (mode == ViewMode.calendar) {
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

enum ViewMode { list, calendar }
