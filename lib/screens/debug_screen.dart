import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introspection_note_mvp/controller/introspection_list_screen_controller.dart';
import 'package:introspection_note_mvp/data/models/introspection_note.dart';
import 'package:introspection_note_mvp/data/repositories/note_repository.dart';
import 'package:uuid/uuid.dart';

class DebugScreen extends StatefulWidget {
  const DebugScreen({super.key});

  @override
  State<DebugScreen> createState() => _DebugScreenState();
}

class _DebugScreenState extends State<DebugScreen> {
  bool _isLoading = false;

  Future<void> _addDummyData() async {
    setState(() {
      _isLoading = true;
    });

    final repository = Get.find<NoteRepository>();
    final random = Random();
    final now = DateTime.now();

    for (int i = 0; i < 30; i++) {
      final daysAgo = random.nextInt(60); // 過去60日間のランダムな日付
      final noteDate = now.subtract(Duration(days: daysAgo));

      final note = IntrospectionNote(
        id: const Uuid().v4(),
        date: noteDate,
        positiveItems: ['ダミーの良いこと ${i + 1}-1', 'ダミーの良いこと ${i + 1}-2'],
        improvementItems: ['ダミーの改善点 ${i + 1}-1', 'ダミーの改善点 ${i + 1}-2'],
        dailyComment: 'これはダミーデータ${i + 1}です。ページネーションのテスト用に追加されました。',
      );

      await repository.add(note);
    }

    if (Get.isRegistered<IntrospectionListScreenController>()) {
      Get.find<IntrospectionListScreenController>().readNotes();
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Get.snackbar('成功', '30件のダミーデータを追加しました。');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('デバッグ画面'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _addDummyData,
                child: const Text('30件のダミーデータを追加する'),
              ),
      ),
    );
  }
}
