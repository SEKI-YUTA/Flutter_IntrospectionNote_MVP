// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'introspection_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntrospectionNote _$IntrospectionNoteFromJson(Map<String, dynamic> json) =>
    _IntrospectionNote(
      id: json['id'] as String?,
      date: DateTime.parse(json['date'] as String),
      positiveItems:
          (json['positiveItems'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      improvementItems:
          (json['improvementItems'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      dailyComment: json['dailyComment'] as String,
    );

Map<String, dynamic> _$IntrospectionNoteToJson(_IntrospectionNote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'positiveItems': instance.positiveItems,
      'improvementItems': instance.improvementItems,
      'dailyComment': instance.dailyComment,
    };
