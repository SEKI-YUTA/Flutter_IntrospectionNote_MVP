import 'package:get/get.dart';
import 'package:introspection_note_mvp/data/models/introspection_note.dart';
import 'package:introspection_note_mvp/data/repositories/note_repository.dart';

class IntrospectionListScreenController extends GetxController {
  final NoteRepository repository;
  IntrospectionListScreenController({required this.repository});

  final _notes = <IntrospectionNote>[].obs;
  final _isLoading = true.obs;
  List<IntrospectionNote> get notes => _notes.toList();
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    _getNotes();
  }

  Future<void> _getNotes() async {
    final notes = await repository.fetchNotes();
    _notes.value = notes;
    _isLoading.value = false;
  }
}
