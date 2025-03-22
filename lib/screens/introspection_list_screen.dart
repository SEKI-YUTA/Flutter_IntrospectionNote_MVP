import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introspection_note_mvp/data/models/introspection_note.dart';
import 'package:introspection_note_mvp/controller/introspection_list_screen_controller.dart';
import 'package:introspection_note_mvp/widget/introspection_card.dart';

class IntrospectionListPage extends StatelessWidget {
  const IntrospectionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IntrospectionListScreenController>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.toNamed("/create_introspection");
          if (result != null) {
            await controller.readNotes();
            print("added count: ${controller.notes.length}");
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                controller.isLoading
                    ? _buildLoading()
                    : _buildListView(controller.notes),
              ],
            ),
          ),
        );
      }),
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

  Widget _buildListView(List<IntrospectionNote> notes) {
    return Expanded(
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: IntrospectionCard(note: notes[index]),
          );
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }
}
