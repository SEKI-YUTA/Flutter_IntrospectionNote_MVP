// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'introspection_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntrospectionNote {

@JsonKey(name: IntrospectionNoteColumnNames.id) String? get id;@JsonKey(name: IntrospectionNoteColumnNames.date, fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime get date;@JsonKey(name: IntrospectionNoteColumnNames.positiveItems, fromJson: _listFromJson, toJson: _listToJson) List<String> get positiveItems;@JsonKey(name: IntrospectionNoteColumnNames.improvementItems, fromJson: _listFromJson, toJson: _listToJson) List<String> get improvementItems;@JsonKey(name: IntrospectionNoteColumnNames.dailyComment) String get dailyComment;
/// Create a copy of IntrospectionNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntrospectionNoteCopyWith<IntrospectionNote> get copyWith => _$IntrospectionNoteCopyWithImpl<IntrospectionNote>(this as IntrospectionNote, _$identity);

  /// Serializes this IntrospectionNote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntrospectionNote&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.positiveItems, positiveItems)&&const DeepCollectionEquality().equals(other.improvementItems, improvementItems)&&(identical(other.dailyComment, dailyComment) || other.dailyComment == dailyComment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,const DeepCollectionEquality().hash(positiveItems),const DeepCollectionEquality().hash(improvementItems),dailyComment);

@override
String toString() {
  return 'IntrospectionNote(id: $id, date: $date, positiveItems: $positiveItems, improvementItems: $improvementItems, dailyComment: $dailyComment)';
}


}

/// @nodoc
abstract mixin class $IntrospectionNoteCopyWith<$Res>  {
  factory $IntrospectionNoteCopyWith(IntrospectionNote value, $Res Function(IntrospectionNote) _then) = _$IntrospectionNoteCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: IntrospectionNoteColumnNames.id) String? id,@JsonKey(name: IntrospectionNoteColumnNames.date, fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime date,@JsonKey(name: IntrospectionNoteColumnNames.positiveItems, fromJson: _listFromJson, toJson: _listToJson) List<String> positiveItems,@JsonKey(name: IntrospectionNoteColumnNames.improvementItems, fromJson: _listFromJson, toJson: _listToJson) List<String> improvementItems,@JsonKey(name: IntrospectionNoteColumnNames.dailyComment) String dailyComment
});




}
/// @nodoc
class _$IntrospectionNoteCopyWithImpl<$Res>
    implements $IntrospectionNoteCopyWith<$Res> {
  _$IntrospectionNoteCopyWithImpl(this._self, this._then);

  final IntrospectionNote _self;
  final $Res Function(IntrospectionNote) _then;

/// Create a copy of IntrospectionNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? date = null,Object? positiveItems = null,Object? improvementItems = null,Object? dailyComment = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,positiveItems: null == positiveItems ? _self.positiveItems : positiveItems // ignore: cast_nullable_to_non_nullable
as List<String>,improvementItems: null == improvementItems ? _self.improvementItems : improvementItems // ignore: cast_nullable_to_non_nullable
as List<String>,dailyComment: null == dailyComment ? _self.dailyComment : dailyComment // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _IntrospectionNote implements IntrospectionNote {
  const _IntrospectionNote({@JsonKey(name: IntrospectionNoteColumnNames.id) this.id, @JsonKey(name: IntrospectionNoteColumnNames.date, fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) required this.date, @JsonKey(name: IntrospectionNoteColumnNames.positiveItems, fromJson: _listFromJson, toJson: _listToJson) required final  List<String> positiveItems, @JsonKey(name: IntrospectionNoteColumnNames.improvementItems, fromJson: _listFromJson, toJson: _listToJson) required final  List<String> improvementItems, @JsonKey(name: IntrospectionNoteColumnNames.dailyComment) required this.dailyComment}): _positiveItems = positiveItems,_improvementItems = improvementItems;
  factory _IntrospectionNote.fromJson(Map<String, dynamic> json) => _$IntrospectionNoteFromJson(json);

@override@JsonKey(name: IntrospectionNoteColumnNames.id) final  String? id;
@override@JsonKey(name: IntrospectionNoteColumnNames.date, fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) final  DateTime date;
 final  List<String> _positiveItems;
@override@JsonKey(name: IntrospectionNoteColumnNames.positiveItems, fromJson: _listFromJson, toJson: _listToJson) List<String> get positiveItems {
  if (_positiveItems is EqualUnmodifiableListView) return _positiveItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_positiveItems);
}

 final  List<String> _improvementItems;
@override@JsonKey(name: IntrospectionNoteColumnNames.improvementItems, fromJson: _listFromJson, toJson: _listToJson) List<String> get improvementItems {
  if (_improvementItems is EqualUnmodifiableListView) return _improvementItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_improvementItems);
}

@override@JsonKey(name: IntrospectionNoteColumnNames.dailyComment) final  String dailyComment;

/// Create a copy of IntrospectionNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntrospectionNoteCopyWith<_IntrospectionNote> get copyWith => __$IntrospectionNoteCopyWithImpl<_IntrospectionNote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntrospectionNoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntrospectionNote&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._positiveItems, _positiveItems)&&const DeepCollectionEquality().equals(other._improvementItems, _improvementItems)&&(identical(other.dailyComment, dailyComment) || other.dailyComment == dailyComment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,const DeepCollectionEquality().hash(_positiveItems),const DeepCollectionEquality().hash(_improvementItems),dailyComment);

@override
String toString() {
  return 'IntrospectionNote(id: $id, date: $date, positiveItems: $positiveItems, improvementItems: $improvementItems, dailyComment: $dailyComment)';
}


}

/// @nodoc
abstract mixin class _$IntrospectionNoteCopyWith<$Res> implements $IntrospectionNoteCopyWith<$Res> {
  factory _$IntrospectionNoteCopyWith(_IntrospectionNote value, $Res Function(_IntrospectionNote) _then) = __$IntrospectionNoteCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: IntrospectionNoteColumnNames.id) String? id,@JsonKey(name: IntrospectionNoteColumnNames.date, fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime date,@JsonKey(name: IntrospectionNoteColumnNames.positiveItems, fromJson: _listFromJson, toJson: _listToJson) List<String> positiveItems,@JsonKey(name: IntrospectionNoteColumnNames.improvementItems, fromJson: _listFromJson, toJson: _listToJson) List<String> improvementItems,@JsonKey(name: IntrospectionNoteColumnNames.dailyComment) String dailyComment
});




}
/// @nodoc
class __$IntrospectionNoteCopyWithImpl<$Res>
    implements _$IntrospectionNoteCopyWith<$Res> {
  __$IntrospectionNoteCopyWithImpl(this._self, this._then);

  final _IntrospectionNote _self;
  final $Res Function(_IntrospectionNote) _then;

/// Create a copy of IntrospectionNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? date = null,Object? positiveItems = null,Object? improvementItems = null,Object? dailyComment = null,}) {
  return _then(_IntrospectionNote(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,positiveItems: null == positiveItems ? _self._positiveItems : positiveItems // ignore: cast_nullable_to_non_nullable
as List<String>,improvementItems: null == improvementItems ? _self._improvementItems : improvementItems // ignore: cast_nullable_to_non_nullable
as List<String>,dailyComment: null == dailyComment ? _self.dailyComment : dailyComment // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
