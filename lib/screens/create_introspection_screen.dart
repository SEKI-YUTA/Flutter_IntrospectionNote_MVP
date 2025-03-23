import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introspection_note_mvp/controller/create_instropection_screen_controller.dart';
import 'package:introspection_note_mvp/util/util.dart';

class CreateIntrospectionPage
    extends GetView<CreateInstropectionScreenController> {
  const CreateIntrospectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateInstropectionScreenController>();
    bool _isDarkTheme = isDarkTheme(context);
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              // メインコンテンツ
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ヘッダー
                    _buildHeader(_isDarkTheme),
                    const SizedBox(height: 16),

                    // フォームカード
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Color(0xFFE4E4E7)),
                      ),
                      elevation: 1,
                      shadowColor: Colors.black.withValues(alpha: 0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 日付
                            Text(
                              controller.getFormattedDate(),
                              style: const TextStyle(
                                fontFamily: 'Geist',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.5,
                                color: Color(0xFF0F766E),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // 良かった点セクション
                            const Text(
                              "良かった点",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF047857),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // 良かった点入力フィールドのリスト
                            _buildPositiveFields(),

                            // 良かった点の項目追加ボタン
                            _buildAddItemButton(
                              onPressed: controller.addPositiveItem,
                              labelText: "項目を追加",
                              color: const Color(0xFF059669),
                            ),
                            const SizedBox(height: 24),

                            // 改善点セクション
                            const Text(
                              "改善点",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFB45309),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // 改善点入力フィールドのリスト
                            _buildImprovementFields(),

                            // 改善点の項目追加ボタン
                            _buildAddItemButton(
                              onPressed: controller.addImprovementItem,
                              labelText: "項目を追加",
                              color: const Color(0xFFD97706),
                            ),
                            const SizedBox(height: 24),

                            // 1日の感想セクション
                            const Text(
                              "1日の感想",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1D4ED8),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // 感想入力エリア
                            TextField(
                              controller: controller.commentController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE4E4E7),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF0D9488),
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                              ),
                              minLines: 3,
                              maxLines: 5,
                            ),
                            const SizedBox(height: 24),

                            // 保存ボタン
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:
                                    controller.isSaving
                                        ? null // 保存中は押せないように
                                        : controller.saveReflection,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0D9488),
                                  foregroundColor: const Color(0xFFFAFAFA),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  disabledBackgroundColor: const Color(
                                    0xFF0D9488,
                                  ).withOpacity(0.5),
                                ),
                                child: Text(
                                  controller.isEditMode ? "更新する" : "保存する",
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 保存中のローディングインジケーター
              if (controller.isSaving)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(color: Color(0xFF0D9488)),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  // ヘッダーウィジェットの構築
  Widget _buildHeader(bool isDarkTheme) {
    return Row(
      children: [
        // 戻るボタン
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        const SizedBox(width: 8),
        // タイトル
        Text(
          controller.isEditMode ? "内省の編集" : "内省の記録",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F766E),
          ),
        ),
      ],
    );
  }

  // 良かった点の入力フィールドリストを構築
  Widget _buildPositiveFields() {
    return Column(
      children: List.generate(controller.positiveItems.length, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              // 入力フィールド
              Expanded(
                child: TextField(
                  controller: controller.positiveItems[i],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    hintText: "良かったことを入力",
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Color(0xFF71717A),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFFE4E4E7)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFF047857)),
                    ),
                  ),
                  style: const TextStyle(fontFamily: 'Inter', fontSize: 14),
                ),
              ),

              if (i > 0)
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFFEF4444),
                  ),
                  onPressed: () => controller.removePositiveItem(i),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildImprovementFields() {
    return Column(
      children: List.generate(controller.improvementItems.length, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              // 入力フィールド
              Expanded(
                child: TextField(
                  controller: controller.improvementItems[i],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFFE4E4E7)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFFB45309)),
                    ),
                  ),
                  style: const TextStyle(fontFamily: 'Inter', fontSize: 14),
                ),
              ),

              // 2つ目以降の項目には削除ボタンを表示（必要に応じて）
              if (i > 0)
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFFEF4444),
                  ),
                  onPressed: () => controller.removeImprovementItem(i),
                ),
            ],
          ),
        );
      }),
    );
  }

  // 項目追加ボタンを構築
  Widget _buildAddItemButton({
    required VoidCallback onPressed,
    required String labelText,
    required Color color,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.add, color: color),
      label: Text(
        labelText,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFE4E4E7)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    );
  }
}
