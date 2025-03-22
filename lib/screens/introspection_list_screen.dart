import 'package:flutter/material.dart';
import 'package:introspection_note_mvp/models/introspection_note.dart';
import 'package:introspection_note_mvp/repositories/note_repository.dart';
import 'package:introspection_note_mvp/widget/introspection_card.dart';

class IntrospectionListPage extends StatefulWidget {
  const IntrospectionListPage({Key? key}) : super(key: key);

  @override
  State<IntrospectionListPage> createState() => _IntrospectionListPageState();
}

class _IntrospectionListPageState extends State<IntrospectionListPage> {
  int _selectedTabIndex = 0;
  List<IntrospectionNote> _notes = [];

  @override
  void initState() {
    super.initState();
    _getNotes();
  }

  Future<void> _getNotes() async {
    var repository = NoteRepositoryImpl();
    final notes = await repository.fetchNotes();
    setState(() {
      _notes = notes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              Expanded(
                child:
                    _selectedTabIndex == 0
                        ? _buildListView()
                        : const Center(child: Text('カレンダー表示（実装予定）')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '内省ノート',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F766E),
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _notes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: IntrospectionCard(note: _notes[index]),
        );
      },
    );
  }
}
