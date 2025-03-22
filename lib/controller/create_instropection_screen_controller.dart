import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:introspection_note_mvp/data/repositories/note_repository.dart';

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

  // プライベート変数
  final _date = DateTime.now().obs;
  final _positiveItems = <InstropectionItem>[].obs;
  final _improvementItems = <InstropectionItem>[].obs;
  final _isSaving = false.obs;
  final _isEditMode = false.obs;

  // コメント用コントローラー
  final commentController = TextEditingController();

  // 編集対象のID
  String? editId;

  // ゲッター
  DateTime get date => _date.value;
  List<InstropectionItem> get positiveItems => _positiveItems.toList();
  List<InstropectionItem> get improvementItems => _improvementItems.toList();
  bool get isSaving => _isSaving.value;
  bool get isEditMode => _isEditMode.value;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() {
    // 初期データをセット
    _positiveItems.add(InstropectionItem(initialText: ""));
    _positiveItems.add(InstropectionItem()); // 空の入力フィールド用

    _improvementItems.add(InstropectionItem(initialText: ""));

    commentController.text = "";

    // 引数からデータを取得
    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      if (args.containsKey('instropection')) {
        _setupEditMode(args['instropection']);
      }
    }
  }

  // 編集モードの設定
  void _setupEditMode(dynamic reflectionData) {
    _isEditMode.value = true;
    editId = reflectionData['id'];

    // 既存データで上書き
    if (reflectionData['date'] != null) {
      _date.value = reflectionData['date'];
    }

    if (reflectionData['positiveItems'] != null &&
        reflectionData['positiveItems'] is List) {
      _positiveItems.clear();
      final items = reflectionData['positiveItems'] as List;
      for (final item in items) {
        _positiveItems.add(InstropectionItem(initialText: item.toString()));
      }
      _positiveItems.add(InstropectionItem()); // 入力用の空フィールドを追加
    }

    if (reflectionData['improvementItems'] != null &&
        reflectionData['improvementItems'] is List) {
      _improvementItems.clear();
      final items = reflectionData['improvementItems'] as List;
      for (final item in items) {
        _improvementItems.add(InstropectionItem(initialText: item.toString()));
      }
    }

    if (reflectionData['comment'] != null) {
      commentController.text = reflectionData['comment'].toString();
    }
  }

  @override
  void onClose() {
    // コントローラーの破棄
    for (var item in _positiveItems) {
      item.dispose();
    }
    for (var item in _improvementItems) {
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
    _positiveItems.add(InstropectionItem());
  }

  // 良かった点の項目を削除
  void removePositiveItem(int index) {
    if (index >= 0 && index < _positiveItems.length) {
      final item = _positiveItems[index];
      item.dispose();
      _positiveItems.removeAt(index);
    }
  }

  // 改善点の項目を追加
  void addImprovementItem() {
    _improvementItems.add(InstropectionItem());
  }

  // 改善点の項目を削除
  void removeImprovementItem(int index) {
    if (index >= 0 && index < _improvementItems.length) {
      final item = _improvementItems[index];
      item.dispose();
      _improvementItems.removeAt(index);
    }
  }

  // 内省データを保存
  Future<void> saveReflection() async {
    try {
      _isSaving.value = true;

      // 空でない項目のテキストを取得
      final positiveTexts =
          _positiveItems
              .map((item) => item.controller.text)
              .where((text) => text.isNotEmpty)
              .toList();

      final improvementTexts =
          _improvementItems
              .map((item) => item.controller.text)
              .where((text) => text.isNotEmpty)
              .toList();

      final comment = commentController.text;

      // 保存データの作成
      final reflectionData = {
        'date': _date.value,
        'positiveItems': positiveTexts,
        'improvementItems': improvementTexts,
        'comment': comment,
      };

      // 編集モードの場合はIDも追加
      if (_isEditMode.value && editId != null) {
        reflectionData['id'] = editId!;
      }

      // ここで実際のデータ保存処理を行う
      // 例: isEditMode.value
      //     ? await repository.updateReflection(reflectionData)
      //     : await repository.createReflection(reflectionData);

      // 保存成功後の処理
      await Future.delayed(const Duration(milliseconds: 500)); // 保存処理のシミュレーション

      Get.back(result: reflectionData); // 結果を返しながら前の画面に戻る
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
