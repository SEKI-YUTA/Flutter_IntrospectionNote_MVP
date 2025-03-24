import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'introspection_note.freezed.dart';
part 'introspection_note.g.dart';

@freezed
abstract class IntrospectionNote with _$IntrospectionNote {
  const factory IntrospectionNote({
    @JsonKey(name: 'id') String? id,

    @JsonKey(name: 'date', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime date,

    @JsonKey(
      name: 'positive_items',
      fromJson: _listFromJson,
      toJson: _listToJson,
    )
    required List<String> positiveItems,

    @JsonKey(
      name: 'improvement_items',
      fromJson: _listFromJson,
      toJson: _listToJson,
    )
    required List<String> improvementItems,

    @JsonKey(name: 'daily_comment') required String dailyComment,
  }) = _IntrospectionNote;

  factory IntrospectionNote.fromJson(Map<String, dynamic> json) =>
      _$IntrospectionNoteFromJson(json);
}

// DateTime変換
DateTime _dateTimeFromJson(String dateString) => DateTime.parse(dateString);
String _dateTimeToJson(DateTime date) => date.toIso8601String();

// リスト変換（SQLiteに保存するために文字列として扱う）
List<String> _listFromJson(dynamic json) {
  if (json is String) {
    // SQLiteから読み込んだJSON文字列の場合
    try {
      final List<dynamic> parsed = jsonDecode(json);
      return parsed.map((e) => e.toString()).toList();
    } catch (e) {
      return [];
    }
  } else if (json is List) {
    // 通常のJSONの場合
    return json.map((e) => e.toString()).toList();
  }
  return [];
}

String _listToJson(List<String> list) {
  // リストを通常のList<String>に変換してからJSON文字列に変換
  return jsonEncode(list.toList());
}
