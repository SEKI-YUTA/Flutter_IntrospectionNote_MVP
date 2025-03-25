// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'introspection_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntrospectionNote _$IntrospectionNoteFromJson(Map<String, dynamic> json) =>
    _IntrospectionNote(
      id: json['id'] as String?,
      date: _dateTimeFromJson(json['date'] as String),
      positiveItems: _listFromJson(json['positive_items']),
      improvementItems: _listFromJson(json['improvement_items']),
      dailyComment: json['daily_comment'] as String,
    );

Map<String, dynamic> _$IntrospectionNoteToJson(_IntrospectionNote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': _dateTimeToJson(instance.date),
      'positive_items': _listToJson(instance.positiveItems),
      'improvement_items': _listToJson(instance.improvementItems),
      'daily_comment': instance.dailyComment,
    };
