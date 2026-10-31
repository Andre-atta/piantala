// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RoomEntity _$RoomEntityFromJson(Map<String, dynamic> json) {
  return _RoomEntity.fromJson(json);
}

/// @nodoc
mixin _$RoomEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// N | NE | E | SE | S | SW | W | NW | UNKNOWN
  String get exposure => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get exposureConfirmedByUser => throw _privateConstructorUsedError;
  int? get floor => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomEntityCopyWith<RoomEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomEntityCopyWith<$Res> {
  factory $RoomEntityCopyWith(
          RoomEntity value, $Res Function(RoomEntity) then) =
      _$RoomEntityCopyWithImpl<$Res, RoomEntity>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      String exposure,
      DateTime createdAt,
      bool exposureConfirmedByUser,
      int? floor,
      String? notes});
}

/// @nodoc
class _$RoomEntityCopyWithImpl<$Res, $Val extends RoomEntity>
    implements $RoomEntityCopyWith<$Res> {
  _$RoomEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? exposure = null,
    Object? createdAt = null,
    Object? exposureConfirmedByUser = null,
    Object? floor = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exposure: null == exposure
          ? _value.exposure
          : exposure // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      exposureConfirmedByUser: null == exposureConfirmedByUser
          ? _value.exposureConfirmedByUser
          : exposureConfirmedByUser // ignore: cast_nullable_to_non_nullable
              as bool,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomEntityImplCopyWith<$Res>
    implements $RoomEntityCopyWith<$Res> {
  factory _$$RoomEntityImplCopyWith(
          _$RoomEntityImpl value, $Res Function(_$RoomEntityImpl) then) =
      __$$RoomEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      String exposure,
      DateTime createdAt,
      bool exposureConfirmedByUser,
      int? floor,
      String? notes});
}

/// @nodoc
class __$$RoomEntityImplCopyWithImpl<$Res>
    extends _$RoomEntityCopyWithImpl<$Res, _$RoomEntityImpl>
    implements _$$RoomEntityImplCopyWith<$Res> {
  __$$RoomEntityImplCopyWithImpl(
      _$RoomEntityImpl _value, $Res Function(_$RoomEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? exposure = null,
    Object? createdAt = null,
    Object? exposureConfirmedByUser = null,
    Object? floor = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$RoomEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exposure: null == exposure
          ? _value.exposure
          : exposure // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      exposureConfirmedByUser: null == exposureConfirmedByUser
          ? _value.exposureConfirmedByUser
          : exposureConfirmedByUser // ignore: cast_nullable_to_non_nullable
              as bool,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomEntityImpl implements _RoomEntity {
  const _$RoomEntityImpl(
      {required this.id,
      required this.userId,
      required this.name,
      required this.exposure,
      required this.createdAt,
      this.exposureConfirmedByUser = false,
      this.floor,
      this.notes});

  factory _$RoomEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;

  /// N | NE | E | SE | S | SW | W | NW | UNKNOWN
  @override
  final String exposure;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool exposureConfirmedByUser;
  @override
  final int? floor;
  @override
  final String? notes;

  @override
  String toString() {
    return 'RoomEntity(id: $id, userId: $userId, name: $name, exposure: $exposure, createdAt: $createdAt, exposureConfirmedByUser: $exposureConfirmedByUser, floor: $floor, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.exposure, exposure) ||
                other.exposure == exposure) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(
                    other.exposureConfirmedByUser, exposureConfirmedByUser) ||
                other.exposureConfirmedByUser == exposureConfirmedByUser) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, name, exposure,
      createdAt, exposureConfirmedByUser, floor, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomEntityImplCopyWith<_$RoomEntityImpl> get copyWith =>
      __$$RoomEntityImplCopyWithImpl<_$RoomEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomEntityImplToJson(
      this,
    );
  }
}

abstract class _RoomEntity implements RoomEntity {
  const factory _RoomEntity(
      {required final String id,
      required final String userId,
      required final String name,
      required final String exposure,
      required final DateTime createdAt,
      final bool exposureConfirmedByUser,
      final int? floor,
      final String? notes}) = _$RoomEntityImpl;

  factory _RoomEntity.fromJson(Map<String, dynamic> json) =
      _$RoomEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get name;
  @override

  /// N | NE | E | SE | S | SW | W | NW | UNKNOWN
  String get exposure;
  @override
  DateTime get createdAt;
  @override
  bool get exposureConfirmedByUser;
  @override
  int? get floor;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$RoomEntityImplCopyWith<_$RoomEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
