import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:introspection_note_mvp/data/models/create_from_color_scheme.dart';
import 'package:introspection_note_mvp/data/models/introspection_note.dart';
import 'package:introspection_note_mvp/util/util.dart';

class IntrospectionCard extends StatelessWidget {

  const IntrospectionCard({
    super.key,
    required this.note,
    required this.introspectionColor,
    this.allowManipulation = true,
    required this.onEdit,
    required this.onDelete,
  });
  final IntrospectionNote note;
  final IntrospectionColor introspectionColor;
  final bool allowManipulation;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy年MM月dd日', 'ja_JP');
    final weekdayFormat = DateFormat('（E）', 'ja_JP');
    final formattedDate =
        '${dateFormat.format(note.date)}${weekdayFormat.format(note.date)}';
    final bool isDarkTheme = checkIsDarkTheme(context);

    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF1F2937) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE4E4E7), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                    isDarkTheme
                        ? [const Color(0xFF1B1B1B), Colors.black]
                        : [const Color(0xFFF0FDFA), Colors.white],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        color: introspectionColor.commonToolToneColor,
                      ),
                      onPressed: () {
                        if (!allowManipulation) {
                          return;
                        }
                        onEdit();
                      },
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(8),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: introspectionColor.dangerToolToneColor,
                      ),
                      onPressed: () {
                        if (!allowManipulation) {
                          return;
                        }
                        onDelete();
                      },
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(8),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                Icon(
                  Icons.thumb_up_outlined,
                  color: introspectionColor.positiveItemsToneColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '良かった点',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: introspectionColor.positiveItemsToneColor,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  note.positiveItems
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• ', style: TextStyle(fontSize: 14)),
                              Expanded(
                                child: Text(
                                  item,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: introspectionColor.improvementItemsToneColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '改善点',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: introspectionColor.improvementItemsToneColor,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  note.improvementItems
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• ', style: TextStyle(fontSize: 14)),
                              Expanded(
                                child: Text(
                                  item,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              '1日の感想',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: introspectionColor.dailyCommentToneColor,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              note.dailyComment,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
