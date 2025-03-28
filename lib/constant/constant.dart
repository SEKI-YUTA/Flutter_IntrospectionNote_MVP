import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:introspection_note_mvp/data/models/create_from_color_scheme.dart';
import 'package:introspection_note_mvp/data/models/introspection_note.dart';
import 'package:uuid/uuid.dart';

final List<IntrospectionNote> notes = [
  IntrospectionNote(
    id: const Uuid().v6(),
    date: DateTime(2025, 3, 19),
    positiveItems: ['新しいスキルの学習を始めた', '健康的な食事を維持できた'],
    improvementItems: ['SNSに費やす時間を減らす', 'もっと水を飲む'],
    dailyComment: '今日は新しいことに挑戦する日だった。少し\n疲れたが、充実感がある。',
  ),
  IntrospectionNote(
    id: const Uuid().v6(),
    date: DateTime(2025, 3, 20),
    positiveItems: ['プロジェクトの締め切りに間に合った', '同僚にフィードバックを提供した'],
    improvementItems: ['朝の時間管理をもっと効率的にする', 'ミーティングの準備をもっと早くする'],
    dailyComment: '今日は忙しかったが、全体的に生産的な一日\nだった。明日はもう少し早く起きて朝の時間\nを有効活用したい。',
  ),
];

// ignore_for_file: constant_identifier_names
class CreateFormColors {
  static const Light = IntrospectionColor(
    positiveItemsToneColor: Color(0xFF047857),
    improvementItemsToneColor: Color(0xFFB45309),
    dailyCommentToneColor: Color(0xFF1D4ED8),
    commonToolToneColor: Color(0xFF0D9488),
    dangerToolToneColor: Color(0xFFB03535),
  );

  static const Dark = IntrospectionColor(
    positiveItemsToneColor: Color(0xFF0ACC95),
    improvementItemsToneColor: Color(0xFFF28A30),
    dailyCommentToneColor: Color(0xFF4285F4),
    commonToolToneColor: Color(0xFF14D0BC),
    dangerToolToneColor: Color(0xFFFF6B6B),
  );
}
