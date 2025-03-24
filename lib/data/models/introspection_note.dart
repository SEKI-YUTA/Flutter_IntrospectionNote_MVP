import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'introspection_note.freezed.dart';
part 'introspection_note.g.dart';

@freezed
abstract class IntrospectionNote with _$IntrospectionNote {
  const factory IntrospectionNote({
    String? id,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime date,
    required List<String> positiveItems,
    required List<String> improvementItems,
    required String dailyComment,
  }) = _IntrospectionNote;

  factory IntrospectionNote.fromJson(Map<String, dynamic> json) =>
      _$IntrospectionNoteFromJson(json);
}

// ISO 8601形式の文字列からDateTimeに変換
DateTime _dateTimeFromJson(String dateString) => DateTime.parse(dateString);

// DateTimeからISO 8601形式の文字列に変換
String _dateTimeToJson(DateTime date) => date.toIso8601String();
