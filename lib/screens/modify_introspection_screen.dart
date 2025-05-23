import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introspection_note_mvp/controller/modify_instropection_screen_controller.dart';
import 'package:introspection_note_mvp/data/models/modify_form_color_scheme.dart';
import 'package:introspection_note_mvp/util/util.dart';

class CreateIntrospectionPage
    extends GetView<CreateInstropectionScreenController> {
  const CreateIntrospectionPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = checkIsDarkTheme(context);
    final IntrospectionColor introspectionColor = getFormColorScheme(context);
    return Scaffold(
      appBar: AppBar(title: Text(controller.isEditMode ? '内省の編集' : '内省の記録')),
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

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
                            GestureDetector(
                              onTap: controller.changeDate,
                              child: Row(
                                children: [
                                  Text(
                                    controller.getFormattedDate(),
                                    style: TextStyle(
                                      fontFamily: 'Geist',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.5,
                                      color:
                                          isDarkTheme
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                  const Icon(Icons.arrow_drop_down_rounded),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),

                            Text(
                              '良かった点',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color:
                                    introspectionColor.positiveItemsToneColor,
                              ),
                            ),
                            const SizedBox(height: 8),

                            _buildPositiveFields(
                              introspectionColor.positiveItemsToneColor,
                            ),

                            _buildAddItemButton(
                              onPressed: controller.addPositiveItem,
                              labelText: '項目を追加',
                              color: const Color(0xFF059669),
                            ),
                            const SizedBox(height: 24),

                            Text(
                              '改善点',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color:
                                    introspectionColor
                                        .improvementItemsToneColor,
                              ),
                            ),
                            const SizedBox(height: 8),

                            _buildImprovementFields(
                              introspectionColor.improvementItemsToneColor,
                            ),

                            _buildAddItemButton(
                              onPressed: controller.addImprovementItem,
                              labelText: '項目を追加',
                              color: const Color(0xFFD97706),
                            ),
                            const SizedBox(height: 24),

                            Text(
                              '1日の感想',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: introspectionColor.dailyCommentToneColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildDailyCommentField(
                              introspectionColor.dailyCommentToneColor,
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:
                                    controller.isSaving
                                        ? null
                                        : controller.saveIntrospection,
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
                                  ).withValues(alpha: 0.5),
                                ),
                                child: Text(
                                  controller.isEditMode ? '更新する' : '保存する',
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

              if (controller.isSaving)
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
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

  Widget _buildPositiveFields(Color toneColor) {
    return Column(
      children: List.generate(controller.positiveItems.length, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.positiveItems[i],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    hintText: '良かったことを入力',
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
                      borderSide: BorderSide(color: toneColor),
                    ),
                  ),
                  style: const TextStyle(fontFamily: 'Inter', fontSize: 14),
                ),
              ),

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

  Widget _buildImprovementFields(Color toneColor) {
    return Column(
      children: List.generate(controller.improvementItems.length, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.improvementItems[i],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    hintText: '改善点を入力',
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
                      borderSide: BorderSide(color: toneColor),
                    ),
                  ),
                  style: const TextStyle(fontFamily: 'Inter', fontSize: 14),
                ),
              ),

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

  Widget _buildDailyCommentField(Color toneColor) {
    return TextField(
      controller: controller.dailyCommentController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        hintText: '感想を入力',
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
          borderSide: BorderSide(color: toneColor),
        ),
      ),
      style: const TextStyle(fontFamily: 'Inter', fontSize: 14),
      minLines: 3,
      maxLines: 5,
    );
  }

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
