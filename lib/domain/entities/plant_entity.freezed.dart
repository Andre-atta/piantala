// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plant_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlantEntity _$PlantEntityFromJson(Map<String, dynamic> json) {
  return _PlantEntity.fromJson(json);
}

/// @nodoc
mixin _$PlantEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  String get customName => throw _privateConstructorUsedError;
  int get shelfPosition => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get speciesApiId => throw _privateConstructorUsedError;
  String? get speciesCommonName => throw _privateConstructorUsedError;
  String? get speciesScientificName => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  WateringConfigEntity? get wateringConfig =>
      throw _privateConstructorUsedError;
  CareConfigEntity? get careConfig => throw _privateConstructorUsedError;
  FertilizingConfigEntity? get fertilizingConfig =>
      throw _privateConstructorUsedError;
  DateTime? get acquisitionDate => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  bool get isArchived => throw _privateConstructorUsedError;
  String get cultivationMethod => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlantEntityCopyWith<PlantEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlantEntityCopyWith<$Res> {
  factory $PlantEntityCopyWith(
          PlantEntity value, $Res Function(PlantEntity) then) =
      _$PlantEntityCopyWithImpl<$Res, PlantEntity>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String roomId,
      String customName,
      int shelfPosition,
      DateTime createdAt,
      String? speciesApiId,
      String? speciesCommonName,
      String? speciesScientificName,
      String? photoUrl,
      String? thumbnailUrl,
      WateringConfigEntity? wateringConfig,
      CareConfigEntity? careConfig,
      FertilizingConfigEntity? fertilizingConfig,
      DateTime? acquisitionDate,
      String? notes,
      List<String> tags,
      bool isArchived,
      String cultivationMethod});

  $WateringConfigEntityCopyWith<$Res>? get wateringConfig;
  $CareConfigEntityCopyWith<$Res>? get careConfig;
  $FertilizingConfigEntityCopyWith<$Res>? get fertilizingConfig;
}

/// @nodoc
class _$PlantEntityCopyWithImpl<$Res, $Val extends PlantEntity>
    implements $PlantEntityCopyWith<$Res> {
  _$PlantEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? roomId = null,
    Object? customName = null,
    Object? shelfPosition = null,
    Object? createdAt = null,
    Object? speciesApiId = freezed,
    Object? speciesCommonName = freezed,
    Object? speciesScientificName = freezed,
    Object? photoUrl = freezed,
    Object? thumbnailUrl = freezed,
    Object? wateringConfig = freezed,
    Object? careConfig = freezed,
    Object? fertilizingConfig = freezed,
    Object? acquisitionDate = freezed,
    Object? notes = freezed,
    Object? tags = null,
    Object? isArchived = null,
    Object? cultivationMethod = null,
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
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      customName: null == customName
          ? _value.customName
          : customName // ignore: cast_nullable_to_non_nullable
              as String,
      shelfPosition: null == shelfPosition
          ? _value.shelfPosition
          : shelfPosition // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      speciesApiId: freezed == speciesApiId
          ? _value.speciesApiId
          : speciesApiId // ignore: cast_nullable_to_non_nullable
              as String?,
      speciesCommonName: freezed == speciesCommonName
          ? _value.speciesCommonName
          : speciesCommonName // ignore: cast_nullable_to_non_nullable
              as String?,
      speciesScientificName: freezed == speciesScientificName
          ? _value.speciesScientificName
          : speciesScientificName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      wateringConfig: freezed == wateringConfig
          ? _value.wateringConfig
          : wateringConfig // ignore: cast_nullable_to_non_nullable
              as WateringConfigEntity?,
      careConfig: freezed == careConfig
          ? _value.careConfig
          : careConfig // ignore: cast_nullable_to_non_nullable
              as CareConfigEntity?,
      fertilizingConfig: freezed == fertilizingConfig
          ? _value.fertilizingConfig
          : fertilizingConfig // ignore: cast_nullable_to_non_nullable
              as FertilizingConfigEntity?,
      acquisitionDate: freezed == acquisitionDate
          ? _value.acquisitionDate
          : acquisitionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isArchived: null == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      cultivationMethod: null == cultivationMethod
          ? _value.cultivationMethod
          : cultivationMethod // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WateringConfigEntityCopyWith<$Res>? get wateringConfig {
    if (_value.wateringConfig == null) {
      return null;
    }

    return $WateringConfigEntityCopyWith<$Res>(_value.wateringConfig!, (value) {
      return _then(_value.copyWith(wateringConfig: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CareConfigEntityCopyWith<$Res>? get careConfig {
    if (_value.careConfig == null) {
      return null;
    }

    return $CareConfigEntityCopyWith<$Res>(_value.careConfig!, (value) {
      return _then(_value.copyWith(careConfig: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FertilizingConfigEntityCopyWith<$Res>? get fertilizingConfig {
    if (_value.fertilizingConfig == null) {
      return null;
    }

    return $FertilizingConfigEntityCopyWith<$Res>(_value.fertilizingConfig!,
        (value) {
      return _then(_value.copyWith(fertilizingConfig: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlantEntityImplCopyWith<$Res>
    implements $PlantEntityCopyWith<$Res> {
  factory _$$PlantEntityImplCopyWith(
          _$PlantEntityImpl value, $Res Function(_$PlantEntityImpl) then) =
      __$$PlantEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String roomId,
      String customName,
      int shelfPosition,
      DateTime createdAt,
      String? speciesApiId,
      String? speciesCommonName,
      String? speciesScientificName,
      String? photoUrl,
      String? thumbnailUrl,
      WateringConfigEntity? wateringConfig,
      CareConfigEntity? careConfig,
      FertilizingConfigEntity? fertilizingConfig,
      DateTime? acquisitionDate,
      String? notes,
      List<String> tags,
      bool isArchived,
      String cultivationMethod});

  @override
  $WateringConfigEntityCopyWith<$Res>? get wateringConfig;
  @override
  $CareConfigEntityCopyWith<$Res>? get careConfig;
  @override
  $FertilizingConfigEntityCopyWith<$Res>? get fertilizingConfig;
}

/// @nodoc
class __$$PlantEntityImplCopyWithImpl<$Res>
    extends _$PlantEntityCopyWithImpl<$Res, _$PlantEntityImpl>
    implements _$$PlantEntityImplCopyWith<$Res> {
  __$$PlantEntityImplCopyWithImpl(
      _$PlantEntityImpl _value, $Res Function(_$PlantEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? roomId = null,
    Object? customName = null,
    Object? shelfPosition = null,
    Object? createdAt = null,
    Object? speciesApiId = freezed,
    Object? speciesCommonName = freezed,
    Object? speciesScientificName = freezed,
    Object? photoUrl = freezed,
    Object? thumbnailUrl = freezed,
    Object? wateringConfig = freezed,
    Object? careConfig = freezed,
    Object? fertilizingConfig = freezed,
    Object? acquisitionDate = freezed,
    Object? notes = freezed,
    Object? tags = null,
    Object? isArchived = null,
    Object? cultivationMethod = null,
  }) {
    return _then(_$PlantEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      customName: null == customName
          ? _value.customName
          : customName // ignore: cast_nullable_to_non_nullable
              as String,
      shelfPosition: null == shelfPosition
          ? _value.shelfPosition
          : shelfPosition // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      speciesApiId: freezed == speciesApiId
          ? _value.speciesApiId
          : speciesApiId // ignore: cast_nullable_to_non_nullable
              as String?,
      speciesCommonName: freezed == speciesCommonName
          ? _value.speciesCommonName
          : speciesCommonName // ignore: cast_nullable_to_non_nullable
              as String?,
      speciesScientificName: freezed == speciesScientificName
          ? _value.speciesScientificName
          : speciesScientificName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      wateringConfig: freezed == wateringConfig
          ? _value.wateringConfig
          : wateringConfig // ignore: cast_nullable_to_non_nullable
              as WateringConfigEntity?,
      careConfig: freezed == careConfig
          ? _value.careConfig
          : careConfig // ignore: cast_nullable_to_non_nullable
              as CareConfigEntity?,
      fertilizingConfig: freezed == fertilizingConfig
          ? _value.fertilizingConfig
          : fertilizingConfig // ignore: cast_nullable_to_non_nullable
              as FertilizingConfigEntity?,
      acquisitionDate: freezed == acquisitionDate
          ? _value.acquisitionDate
          : acquisitionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isArchived: null == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      cultivationMethod: null == cultivationMethod
          ? _value.cultivationMethod
          : cultivationMethod // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlantEntityImpl extends _PlantEntity {
  const _$PlantEntityImpl(
      {required this.id,
      required this.userId,
      required this.roomId,
      required this.customName,
      required this.shelfPosition,
      required this.createdAt,
      this.speciesApiId,
      this.speciesCommonName,
      this.speciesScientificName,
      this.photoUrl,
      this.thumbnailUrl,
      this.wateringConfig,
      this.careConfig,
      this.fertilizingConfig,
      this.acquisitionDate,
      this.notes,
      final List<String> tags = const [],
      this.isArchived = false,
      this.cultivationMethod = 'soil'})
      : _tags = tags,
        super._();

  factory _$PlantEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlantEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String roomId;
  @override
  final String customName;
  @override
  final int shelfPosition;
  @override
  final DateTime createdAt;
  @override
  final String? speciesApiId;
  @override
  final String? speciesCommonName;
  @override
  final String? speciesScientificName;
  @override
  final String? photoUrl;
  @override
  final String? thumbnailUrl;
  @override
  final WateringConfigEntity? wateringConfig;
  @override
  final CareConfigEntity? careConfig;
  @override
  final FertilizingConfigEntity? fertilizingConfig;
  @override
  final DateTime? acquisitionDate;
  @override
  final String? notes;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final bool isArchived;
  @override
  @JsonKey()
  final String cultivationMethod;

  @override
  String toString() {
    return 'PlantEntity(id: $id, userId: $userId, roomId: $roomId, customName: $customName, shelfPosition: $shelfPosition, createdAt: $createdAt, speciesApiId: $speciesApiId, speciesCommonName: $speciesCommonName, speciesScientificName: $speciesScientificName, photoUrl: $photoUrl, thumbnailUrl: $thumbnailUrl, wateringConfig: $wateringConfig, careConfig: $careConfig, fertilizingConfig: $fertilizingConfig, acquisitionDate: $acquisitionDate, notes: $notes, tags: $tags, isArchived: $isArchived, cultivationMethod: $cultivationMethod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlantEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.customName, customName) ||
                other.customName == customName) &&
            (identical(other.shelfPosition, shelfPosition) ||
                other.shelfPosition == shelfPosition) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.speciesApiId, speciesApiId) ||
                other.speciesApiId == speciesApiId) &&
            (identical(other.speciesCommonName, speciesCommonName) ||
                other.speciesCommonName == speciesCommonName) &&
            (identical(other.speciesScientificName, speciesScientificName) ||
                other.speciesScientificName == speciesScientificName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.wateringConfig, wateringConfig) ||
                other.wateringConfig == wateringConfig) &&
            (identical(other.careConfig, careConfig) ||
                other.careConfig == careConfig) &&
            (identical(other.fertilizingConfig, fertilizingConfig) ||
                other.fertilizingConfig == fertilizingConfig) &&
            (identical(other.acquisitionDate, acquisitionDate) ||
                other.acquisitionDate == acquisitionDate) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            (identical(other.cultivationMethod, cultivationMethod) ||
                other.cultivationMethod == cultivationMethod));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        roomId,
        customName,
        shelfPosition,
        createdAt,
        speciesApiId,
        speciesCommonName,
        speciesScientificName,
        photoUrl,
        thumbnailUrl,
        wateringConfig,
        careConfig,
        fertilizingConfig,
        acquisitionDate,
        notes,
        const DeepCollectionEquality().hash(_tags),
        isArchived,
        cultivationMethod
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlantEntityImplCopyWith<_$PlantEntityImpl> get copyWith =>
      __$$PlantEntityImplCopyWithImpl<_$PlantEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlantEntityImplToJson(
      this,
    );
  }
}

abstract class _PlantEntity extends PlantEntity {
  const factory _PlantEntity(
      {required final String id,
      required final String userId,
      required final String roomId,
      required final String customName,
      required final int shelfPosition,
      required final DateTime createdAt,
      final String? speciesApiId,
      final String? speciesCommonName,
      final String? speciesScientificName,
      final String? photoUrl,
      final String? thumbnailUrl,
      final WateringConfigEntity? wateringConfig,
      final CareConfigEntity? careConfig,
      final FertilizingConfigEntity? fertilizingConfig,
      final DateTime? acquisitionDate,
      final String? notes,
      final List<String> tags,
      final bool isArchived,
      final String cultivationMethod}) = _$PlantEntityImpl;
  const _PlantEntity._() : super._();

  factory _PlantEntity.fromJson(Map<String, dynamic> json) =
      _$PlantEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get roomId;
  @override
  String get customName;
  @override
  int get shelfPosition;
  @override
  DateTime get createdAt;
  @override
  String? get speciesApiId;
  @override
  String? get speciesCommonName;
  @override
  String? get speciesScientificName;
  @override
  String? get photoUrl;
  @override
  String? get thumbnailUrl;
  @override
  WateringConfigEntity? get wateringConfig;
  @override
  CareConfigEntity? get careConfig;
  @override
  FertilizingConfigEntity? get fertilizingConfig;
  @override
  DateTime? get acquisitionDate;
  @override
  String? get notes;
  @override
  List<String> get tags;
  @override
  bool get isArchived;
  @override
  String get cultivationMethod;
  @override
  @JsonKey(ignore: true)
  _$$PlantEntityImplCopyWith<_$PlantEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WateringConfigEntity _$WateringConfigEntityFromJson(Map<String, dynamic> json) {
  return _WateringConfigEntity.fromJson(json);
}

/// @nodoc
mixin _$WateringConfigEntity {
  int get frequencyDays => throw _privateConstructorUsedError;
  DateTime? get lastWateredAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WateringConfigEntityCopyWith<WateringConfigEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WateringConfigEntityCopyWith<$Res> {
  factory $WateringConfigEntityCopyWith(WateringConfigEntity value,
          $Res Function(WateringConfigEntity) then) =
      _$WateringConfigEntityCopyWithImpl<$Res, WateringConfigEntity>;
  @useResult
  $Res call({int frequencyDays, DateTime? lastWateredAt});
}

/// @nodoc
class _$WateringConfigEntityCopyWithImpl<$Res,
        $Val extends WateringConfigEntity>
    implements $WateringConfigEntityCopyWith<$Res> {
  _$WateringConfigEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequencyDays = null,
    Object? lastWateredAt = freezed,
  }) {
    return _then(_value.copyWith(
      frequencyDays: null == frequencyDays
          ? _value.frequencyDays
          : frequencyDays // ignore: cast_nullable_to_non_nullable
              as int,
      lastWateredAt: freezed == lastWateredAt
          ? _value.lastWateredAt
          : lastWateredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WateringConfigEntityImplCopyWith<$Res>
    implements $WateringConfigEntityCopyWith<$Res> {
  factory _$$WateringConfigEntityImplCopyWith(_$WateringConfigEntityImpl value,
          $Res Function(_$WateringConfigEntityImpl) then) =
      __$$WateringConfigEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int frequencyDays, DateTime? lastWateredAt});
}

/// @nodoc
class __$$WateringConfigEntityImplCopyWithImpl<$Res>
    extends _$WateringConfigEntityCopyWithImpl<$Res, _$WateringConfigEntityImpl>
    implements _$$WateringConfigEntityImplCopyWith<$Res> {
  __$$WateringConfigEntityImplCopyWithImpl(_$WateringConfigEntityImpl _value,
      $Res Function(_$WateringConfigEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequencyDays = null,
    Object? lastWateredAt = freezed,
  }) {
    return _then(_$WateringConfigEntityImpl(
      frequencyDays: null == frequencyDays
          ? _value.frequencyDays
          : frequencyDays // ignore: cast_nullable_to_non_nullable
              as int,
      lastWateredAt: freezed == lastWateredAt
          ? _value.lastWateredAt
          : lastWateredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WateringConfigEntityImpl implements _WateringConfigEntity {
  const _$WateringConfigEntityImpl(
      {required this.frequencyDays, this.lastWateredAt});

  factory _$WateringConfigEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$WateringConfigEntityImplFromJson(json);

  @override
  final int frequencyDays;
  @override
  final DateTime? lastWateredAt;

  @override
  String toString() {
    return 'WateringConfigEntity(frequencyDays: $frequencyDays, lastWateredAt: $lastWateredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WateringConfigEntityImpl &&
            (identical(other.frequencyDays, frequencyDays) ||
                other.frequencyDays == frequencyDays) &&
            (identical(other.lastWateredAt, lastWateredAt) ||
                other.lastWateredAt == lastWateredAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, frequencyDays, lastWateredAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WateringConfigEntityImplCopyWith<_$WateringConfigEntityImpl>
      get copyWith =>
          __$$WateringConfigEntityImplCopyWithImpl<_$WateringConfigEntityImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WateringConfigEntityImplToJson(
      this,
    );
  }
}

abstract class _WateringConfigEntity implements WateringConfigEntity {
  const factory _WateringConfigEntity(
      {required final int frequencyDays,
      final DateTime? lastWateredAt}) = _$WateringConfigEntityImpl;

  factory _WateringConfigEntity.fromJson(Map<String, dynamic> json) =
      _$WateringConfigEntityImpl.fromJson;

  @override
  int get frequencyDays;
  @override
  DateTime? get lastWateredAt;
  @override
  @JsonKey(ignore: true)
  _$$WateringConfigEntityImplCopyWith<_$WateringConfigEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CareConfigEntity _$CareConfigEntityFromJson(Map<String, dynamic> json) {
  return _CareConfigEntity.fromJson(json);
}

/// @nodoc
mixin _$CareConfigEntity {
  int? get fertilizingFrequencyDays => throw _privateConstructorUsedError;
  DateTime? get lastFertilizedAt => throw _privateConstructorUsedError;
  DateTime? get lastRepottedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CareConfigEntityCopyWith<CareConfigEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CareConfigEntityCopyWith<$Res> {
  factory $CareConfigEntityCopyWith(
          CareConfigEntity value, $Res Function(CareConfigEntity) then) =
      _$CareConfigEntityCopyWithImpl<$Res, CareConfigEntity>;
  @useResult
  $Res call(
      {int? fertilizingFrequencyDays,
      DateTime? lastFertilizedAt,
      DateTime? lastRepottedAt});
}

/// @nodoc
class _$CareConfigEntityCopyWithImpl<$Res, $Val extends CareConfigEntity>
    implements $CareConfigEntityCopyWith<$Res> {
  _$CareConfigEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fertilizingFrequencyDays = freezed,
    Object? lastFertilizedAt = freezed,
    Object? lastRepottedAt = freezed,
  }) {
    return _then(_value.copyWith(
      fertilizingFrequencyDays: freezed == fertilizingFrequencyDays
          ? _value.fertilizingFrequencyDays
          : fertilizingFrequencyDays // ignore: cast_nullable_to_non_nullable
              as int?,
      lastFertilizedAt: freezed == lastFertilizedAt
          ? _value.lastFertilizedAt
          : lastFertilizedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastRepottedAt: freezed == lastRepottedAt
          ? _value.lastRepottedAt
          : lastRepottedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CareConfigEntityImplCopyWith<$Res>
    implements $CareConfigEntityCopyWith<$Res> {
  factory _$$CareConfigEntityImplCopyWith(_$CareConfigEntityImpl value,
          $Res Function(_$CareConfigEntityImpl) then) =
      __$$CareConfigEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? fertilizingFrequencyDays,
      DateTime? lastFertilizedAt,
      DateTime? lastRepottedAt});
}

/// @nodoc
class __$$CareConfigEntityImplCopyWithImpl<$Res>
    extends _$CareConfigEntityCopyWithImpl<$Res, _$CareConfigEntityImpl>
    implements _$$CareConfigEntityImplCopyWith<$Res> {
  __$$CareConfigEntityImplCopyWithImpl(_$CareConfigEntityImpl _value,
      $Res Function(_$CareConfigEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fertilizingFrequencyDays = freezed,
    Object? lastFertilizedAt = freezed,
    Object? lastRepottedAt = freezed,
  }) {
    return _then(_$CareConfigEntityImpl(
      fertilizingFrequencyDays: freezed == fertilizingFrequencyDays
          ? _value.fertilizingFrequencyDays
          : fertilizingFrequencyDays // ignore: cast_nullable_to_non_nullable
              as int?,
      lastFertilizedAt: freezed == lastFertilizedAt
          ? _value.lastFertilizedAt
          : lastFertilizedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastRepottedAt: freezed == lastRepottedAt
          ? _value.lastRepottedAt
          : lastRepottedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CareConfigEntityImpl implements _CareConfigEntity {
  const _$CareConfigEntityImpl(
      {this.fertilizingFrequencyDays,
      this.lastFertilizedAt,
      this.lastRepottedAt});

  factory _$CareConfigEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CareConfigEntityImplFromJson(json);

  @override
  final int? fertilizingFrequencyDays;
  @override
  final DateTime? lastFertilizedAt;
  @override
  final DateTime? lastRepottedAt;

  @override
  String toString() {
    return 'CareConfigEntity(fertilizingFrequencyDays: $fertilizingFrequencyDays, lastFertilizedAt: $lastFertilizedAt, lastRepottedAt: $lastRepottedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CareConfigEntityImpl &&
            (identical(
                    other.fertilizingFrequencyDays, fertilizingFrequencyDays) ||
                other.fertilizingFrequencyDays == fertilizingFrequencyDays) &&
            (identical(other.lastFertilizedAt, lastFertilizedAt) ||
                other.lastFertilizedAt == lastFertilizedAt) &&
            (identical(other.lastRepottedAt, lastRepottedAt) ||
                other.lastRepottedAt == lastRepottedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, fertilizingFrequencyDays, lastFertilizedAt, lastRepottedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CareConfigEntityImplCopyWith<_$CareConfigEntityImpl> get copyWith =>
      __$$CareConfigEntityImplCopyWithImpl<_$CareConfigEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CareConfigEntityImplToJson(
      this,
    );
  }
}

abstract class _CareConfigEntity implements CareConfigEntity {
  const factory _CareConfigEntity(
      {final int? fertilizingFrequencyDays,
      final DateTime? lastFertilizedAt,
      final DateTime? lastRepottedAt}) = _$CareConfigEntityImpl;

  factory _CareConfigEntity.fromJson(Map<String, dynamic> json) =
      _$CareConfigEntityImpl.fromJson;

  @override
  int? get fertilizingFrequencyDays;
  @override
  DateTime? get lastFertilizedAt;
  @override
  DateTime? get lastRepottedAt;
  @override
  @JsonKey(ignore: true)
  _$$CareConfigEntityImplCopyWith<_$CareConfigEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FertilizingConfigEntity _$FertilizingConfigEntityFromJson(
    Map<String, dynamic> json) {
  return _FertilizingConfigEntity.fromJson(json);
}

/// @nodoc
mixin _$FertilizingConfigEntity {
  int get frequencyDays => throw _privateConstructorUsedError;
  DateTime? get lastFertilizedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FertilizingConfigEntityCopyWith<FertilizingConfigEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FertilizingConfigEntityCopyWith<$Res> {
  factory $FertilizingConfigEntityCopyWith(FertilizingConfigEntity value,
          $Res Function(FertilizingConfigEntity) then) =
      _$FertilizingConfigEntityCopyWithImpl<$Res, FertilizingConfigEntity>;
  @useResult
  $Res call({int frequencyDays, DateTime? lastFertilizedAt});
}

/// @nodoc
class _$FertilizingConfigEntityCopyWithImpl<$Res,
        $Val extends FertilizingConfigEntity>
    implements $FertilizingConfigEntityCopyWith<$Res> {
  _$FertilizingConfigEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequencyDays = null,
    Object? lastFertilizedAt = freezed,
  }) {
    return _then(_value.copyWith(
      frequencyDays: null == frequencyDays
          ? _value.frequencyDays
          : frequencyDays // ignore: cast_nullable_to_non_nullable
              as int,
      lastFertilizedAt: freezed == lastFertilizedAt
          ? _value.lastFertilizedAt
          : lastFertilizedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FertilizingConfigEntityImplCopyWith<$Res>
    implements $FertilizingConfigEntityCopyWith<$Res> {
  factory _$$FertilizingConfigEntityImplCopyWith(
          _$FertilizingConfigEntityImpl value,
          $Res Function(_$FertilizingConfigEntityImpl) then) =
      __$$FertilizingConfigEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int frequencyDays, DateTime? lastFertilizedAt});
}

/// @nodoc
class __$$FertilizingConfigEntityImplCopyWithImpl<$Res>
    extends _$FertilizingConfigEntityCopyWithImpl<$Res,
        _$FertilizingConfigEntityImpl>
    implements _$$FertilizingConfigEntityImplCopyWith<$Res> {
  __$$FertilizingConfigEntityImplCopyWithImpl(
      _$FertilizingConfigEntityImpl _value,
      $Res Function(_$FertilizingConfigEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequencyDays = null,
    Object? lastFertilizedAt = freezed,
  }) {
    return _then(_$FertilizingConfigEntityImpl(
      frequencyDays: null == frequencyDays
          ? _value.frequencyDays
          : frequencyDays // ignore: cast_nullable_to_non_nullable
              as int,
      lastFertilizedAt: freezed == lastFertilizedAt
          ? _value.lastFertilizedAt
          : lastFertilizedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FertilizingConfigEntityImpl implements _FertilizingConfigEntity {
  const _$FertilizingConfigEntityImpl(
      {required this.frequencyDays, this.lastFertilizedAt});

  factory _$FertilizingConfigEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$FertilizingConfigEntityImplFromJson(json);

  @override
  final int frequencyDays;
  @override
  final DateTime? lastFertilizedAt;

  @override
  String toString() {
    return 'FertilizingConfigEntity(frequencyDays: $frequencyDays, lastFertilizedAt: $lastFertilizedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FertilizingConfigEntityImpl &&
            (identical(other.frequencyDays, frequencyDays) ||
                other.frequencyDays == frequencyDays) &&
            (identical(other.lastFertilizedAt, lastFertilizedAt) ||
                other.lastFertilizedAt == lastFertilizedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, frequencyDays, lastFertilizedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FertilizingConfigEntityImplCopyWith<_$FertilizingConfigEntityImpl>
      get copyWith => __$$FertilizingConfigEntityImplCopyWithImpl<
          _$FertilizingConfigEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FertilizingConfigEntityImplToJson(
      this,
    );
  }
}

abstract class _FertilizingConfigEntity implements FertilizingConfigEntity {
  const factory _FertilizingConfigEntity(
      {required final int frequencyDays,
      final DateTime? lastFertilizedAt}) = _$FertilizingConfigEntityImpl;

  factory _FertilizingConfigEntity.fromJson(Map<String, dynamic> json) =
      _$FertilizingConfigEntityImpl.fromJson;

  @override
  int get frequencyDays;
  @override
  DateTime? get lastFertilizedAt;
  @override
  @JsonKey(ignore: true)
  _$$FertilizingConfigEntityImplCopyWith<_$FertilizingConfigEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
