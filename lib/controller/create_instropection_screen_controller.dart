import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:introspection_note_mvp/data/models/introspection_note.dart';
import 'package:introspection_note_mvp/data/repositories/note_repository.dart';
import 'package:uuid/uuid.dart';

class InstropectionItem {
  final TextEditingController controller;

  InstropectionItem({String initialText = ''})
    : controller = TextEditingController(text: initialText);

  void dispose() {
    controller.dispose();
  }
}

class CreateInstropectionScreenController extends GetxController {
  final NoteRepository repository;
  CreateInstropectionScreenController({required this.repository});

  final _date = DateTime.now().obs;
  final _positiveTextControllers = <TextEditingController>[].obs;
  final _improvementTextControllers = <TextEditingController>[].obs;
  final _isSaving = false.obs;
  final _isEditMode = false.obs;

  final commentController = TextEditingController();

  // 編集対象のID
  String? editId;

  // ゲッター
  DateTime get date => _date.value;
  List<TextEditingController> get positiveItems =>
      _positiveTextControllers.toList();
  List<TextEditingController> get improvementItems =>
      _improvementTextControllers.toList();
  bool get isSaving => _isSaving.value;
  bool get isEditMode => _isEditMode.value;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() {
    _positiveTextControllers.add(TextEditingController());

    _improvementTextControllers.add(TextEditingController());

    commentController.text = "";

    // 引数からデータを取得
    if (Get.arguments != null && Get.arguments is Map) {
      print("Get.arguments: ${Get.arguments}");
      final args = Get.arguments as Map;
      if (args.containsKey('introspection')) {
        _setupEditMode(args['introspection']);
      }
    }
  }

  // 編集モードの設定
  void _setupEditMode(dynamic introspectionData) {
    _isEditMode.value = true;
    editId = introspectionData['id'];

    // 既存データで上書き
    if (introspectionData['date'] != null &&
        introspectionData['date'] is String) {
      final value = DateTime.parse(introspectionData['date'] as String);
      _date.value = value;
    }

    if (introspectionData['positiveItems'] != null &&
        introspectionData['positiveItems'] is List) {
      _positiveTextControllers.clear();
      final items = introspectionData['positiveItems'] as List;

      for (final item in items) {
        _positiveTextControllers.add(
          TextEditingController(text: item.toString()),
        );
      }
    }

    if (introspectionData['improvementItems'] != null &&
        introspectionData['improvementItems'] is List) {
      _improvementTextControllers.clear();
      final items = introspectionData['improvementItems'] as List;
      for (final item in items) {
        _improvementTextControllers.add(
          TextEditingController(text: item.toString()),
        );
      }
    }

    if (introspectionData['dailyComment'] != null) {
      commentController.text = introspectionData['dailyComment'].toString();
    }
  }

  @override
  void onClose() {
    // コントローラーの破棄
    for (var item in _positiveTextControllers) {
      item.dispose();
    }
    for (var item in _improvementTextControllers) {
      item.dispose();
    }
    commentController.dispose();
    super.onClose();
  }

  // フォーマット済みの日付を取得
  String getFormattedDate() {
    final dateFormat = DateFormat('yyyy年MM月dd日', 'ja_JP');
    final weekdayFormat = DateFormat('(E)', 'ja_JP');
    return '${dateFormat.format(_date.value)} ${weekdayFormat.format(_date.value)}';
  }

  // 良かった点の項目を追加
  void addPositiveItem() {
    _positiveTextControllers.add(TextEditingController());
  }

  // 良かった点の項目を削除
  void removePositiveItem(int index) {
    if (index >= 0 && index < _positiveTextControllers.length) {
      final item = _positiveTextControllers[index];
      item.dispose();
      _positiveTextControllers.removeAt(index);
    }
  }

  // 改善点の項目を追加
  void addImprovementItem() {
    _improvementTextControllers.add(TextEditingController());
  }

  // 改善点の項目を削除
  void removeImprovementItem(int index) {
    if (index >= 0 && index < _improvementTextControllers.length) {
      final item = _improvementTextControllers[index];
      item.dispose();
      _improvementTextControllers.removeAt(index);
    }
  }

  // 内省データを保存
  Future<void> saveReflection() async {
    try {
      _isSaving.value = true;

      // 空でない項目のテキストを取得
      final positiveTexts =
          _positiveTextControllers
              .map((item) => item.text)
              .where((text) => text.isNotEmpty)
              .toList();

      final improvementTexts =
          _improvementTextControllers
              .map((item) => item.text)
              .where((text) => text.isNotEmpty)
              .toList();

      final comment = commentController.text;

      // 保存データの作成
      final introspectionData = {
        'date': _date.value,
        'positiveItems': positiveTexts,
        'improvementItems': improvementTexts,
        'dailyComment': comment,
      };

      // 編集モードの場合はIDも追加
      if (_isEditMode.value && editId != null) {
        introspectionData['id'] = editId!;
      } else {
        introspectionData['id'] = Uuid().v6();
      }

      if (introspectionData['date'] is DateTime) {
        introspectionData['date'] =
            (introspectionData['date'] as DateTime).toIso8601String();
      }

      final note = IntrospectionNote.fromJson(introspectionData);
      isEditMode ? await repository.update(note) : await repository.add(note);

      Get.back(result: note); // 結果を返しながら前の画面に戻る
      Get.snackbar(
        _isEditMode.value ? '更新完了' : '保存完了',
        _isEditMode.value ? '内省を更新しました' : '内省を保存しました',
        backgroundColor: const Color(0xFF0D9488),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        'エラー',
        '保存に失敗しました: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      _isSaving.value = false;
    }
  }
}
