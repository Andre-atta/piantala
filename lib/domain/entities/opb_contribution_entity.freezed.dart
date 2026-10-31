// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'opb_contribution_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OpbContributionEntity {
  /// OBBLIGATORIO per create. Il pid interno è derivato abbassando a minuscolo.
  /// Deve essere un binomio scientifico (es. "Monstera deliciosa").
  /// MaxLength: 100.
  String get displayPid => throw _privateConstructorUsedError;

  /// Nome comune / alias (es. "Swiss Cheese Plant"). MaxLength: 100.
  String? get alias => throw _privateConstructorUsedError;

  /// Categoria tassonomica (es. "Aroid"). MaxLength: 100.
  String? get category => throw _privateConstructorUsedError;

  /// Origine geografica (es. "Central America"). MaxLength: 100.
  String? get origin =>
      throw _privateConstructorUsedError; // ── Luce ────────────────────────────────────────────────────────
  /// Luce massima in mmol/m²/giorno.
  int? get maxLightMmol => throw _privateConstructorUsedError;

  /// Luce minima in mmol/m²/giorno.
  int? get minLightMmol => throw _privateConstructorUsedError;

  /// Luce massima in lux.
  int? get maxLightLux => throw _privateConstructorUsedError;

  /// Luce minima in lux.
  int? get minLightLux =>
      throw _privateConstructorUsedError; // ── Temperatura ─────────────────────────────────────────────────
  /// Temperatura massima (°C).
  int? get maxTemp => throw _privateConstructorUsedError;

  /// Temperatura minima (°C).
  int? get minTemp =>
      throw _privateConstructorUsedError; // ── Umidità ambientale ───────────────────────────────────────────
  /// Umidità ambientale massima (%).
  int? get maxEnvHumid => throw _privateConstructorUsedError;

  /// Umidità ambientale minima (%).
  int? get minEnvHumid =>
      throw _privateConstructorUsedError; // ── Umidità del substrato ────────────────────────────────────────
  /// Umidità substrato massima (%).
  int? get maxSoilMoist => throw _privateConstructorUsedError;

  /// Umidità substrato minima (%).
  int? get minSoilMoist =>
      throw _privateConstructorUsedError; // ── Conducibilità elettrica ──────────────────────────────────────
  /// EC massima (µS/cm).
  int? get maxSoilEc => throw _privateConstructorUsedError;

  /// EC minima (µS/cm).
  int? get minSoilEc =>
      throw _privateConstructorUsedError; // ── Istruzioni di cura testuali ──────────────────────────────────
  /// Descrizione esposizione solare. MaxLength: 200.
  String? get sunlight => throw _privateConstructorUsedError;

  /// Istruzioni di irrigazione. MaxLength: 200.
  String? get watering => throw _privateConstructorUsedError;

  /// Istruzioni di concimazione. MaxLength: 250.
  String? get fertilization => throw _privateConstructorUsedError;

  /// Istruzioni di potatura. MaxLength: 200.
  String? get pruning => throw _privateConstructorUsedError;

  /// Tipo di substrato consigliato. MaxLength: 150.
  String? get soil => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OpbContributionEntityCopyWith<OpbContributionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpbContributionEntityCopyWith<$Res> {
  factory $OpbContributionEntityCopyWith(OpbContributionEntity value,
          $Res Function(OpbContributionEntity) then) =
      _$OpbContributionEntityCopyWithImpl<$Res, OpbContributionEntity>;
  @useResult
  $Res call(
      {String displayPid,
      String? alias,
      String? category,
      String? origin,
      int? maxLightMmol,
      int? minLightMmol,
      int? maxLightLux,
      int? minLightLux,
      int? maxTemp,
      int? minTemp,
      int? maxEnvHumid,
      int? minEnvHumid,
      int? maxSoilMoist,
      int? minSoilMoist,
      int? maxSoilEc,
      int? minSoilEc,
      String? sunlight,
      String? watering,
      String? fertilization,
      String? pruning,
      String? soil});
}

/// @nodoc
class _$OpbContributionEntityCopyWithImpl<$Res,
        $Val extends OpbContributionEntity>
    implements $OpbContributionEntityCopyWith<$Res> {
  _$OpbContributionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayPid = null,
    Object? alias = freezed,
    Object? category = freezed,
    Object? origin = freezed,
    Object? maxLightMmol = freezed,
    Object? minLightMmol = freezed,
    Object? maxLightLux = freezed,
    Object? minLightLux = freezed,
    Object? maxTemp = freezed,
    Object? minTemp = freezed,
    Object? maxEnvHumid = freezed,
    Object? minEnvHumid = freezed,
    Object? maxSoilMoist = freezed,
    Object? minSoilMoist = freezed,
    Object? maxSoilEc = freezed,
    Object? minSoilEc = freezed,
    Object? sunlight = freezed,
    Object? watering = freezed,
    Object? fertilization = freezed,
    Object? pruning = freezed,
    Object? soil = freezed,
  }) {
    return _then(_value.copyWith(
      displayPid: null == displayPid
          ? _value.displayPid
          : displayPid // ignore: cast_nullable_to_non_nullable
              as String,
      alias: freezed == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      origin: freezed == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String?,
      maxLightMmol: freezed == maxLightMmol
          ? _value.maxLightMmol
          : maxLightMmol // ignore: cast_nullable_to_non_nullable
              as int?,
      minLightMmol: freezed == minLightMmol
          ? _value.minLightMmol
          : minLightMmol // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLightLux: freezed == maxLightLux
          ? _value.maxLightLux
          : maxLightLux // ignore: cast_nullable_to_non_nullable
              as int?,
      minLightLux: freezed == minLightLux
          ? _value.minLightLux
          : minLightLux // ignore: cast_nullable_to_non_nullable
              as int?,
      maxTemp: freezed == maxTemp
          ? _value.maxTemp
          : maxTemp // ignore: cast_nullable_to_non_nullable
              as int?,
      minTemp: freezed == minTemp
          ? _value.minTemp
          : minTemp // ignore: cast_nullable_to_non_nullable
              as int?,
      maxEnvHumid: freezed == maxEnvHumid
          ? _value.maxEnvHumid
          : maxEnvHumid // ignore: cast_nullable_to_non_nullable
              as int?,
      minEnvHumid: freezed == minEnvHumid
          ? _value.minEnvHumid
          : minEnvHumid // ignore: cast_nullable_to_non_nullable
              as int?,
      maxSoilMoist: freezed == maxSoilMoist
          ? _value.maxSoilMoist
          : maxSoilMoist // ignore: cast_nullable_to_non_nullable
              as int?,
      minSoilMoist: freezed == minSoilMoist
          ? _value.minSoilMoist
          : minSoilMoist // ignore: cast_nullable_to_non_nullable
              as int?,
      maxSoilEc: freezed == maxSoilEc
          ? _value.maxSoilEc
          : maxSoilEc // ignore: cast_nullable_to_non_nullable
              as int?,
      minSoilEc: freezed == minSoilEc
          ? _value.minSoilEc
          : minSoilEc // ignore: cast_nullable_to_non_nullable
              as int?,
      sunlight: freezed == sunlight
          ? _value.sunlight
          : sunlight // ignore: cast_nullable_to_non_nullable
              as String?,
      watering: freezed == watering
          ? _value.watering
          : watering // ignore: cast_nullable_to_non_nullable
              as String?,
      fertilization: freezed == fertilization
          ? _value.fertilization
          : fertilization // ignore: cast_nullable_to_non_nullable
              as String?,
      pruning: freezed == pruning
          ? _value.pruning
          : pruning // ignore: cast_nullable_to_non_nullable
              as String?,
      soil: freezed == soil
          ? _value.soil
          : soil // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OpbContributionEntityImplCopyWith<$Res>
    implements $OpbContributionEntityCopyWith<$Res> {
  factory _$$OpbContributionEntityImplCopyWith(
          _$OpbContributionEntityImpl value,
          $Res Function(_$OpbContributionEntityImpl) then) =
      __$$OpbContributionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String displayPid,
      String? alias,
      String? category,
      String? origin,
      int? maxLightMmol,
      int? minLightMmol,
      int? maxLightLux,
      int? minLightLux,
      int? maxTemp,
      int? minTemp,
      int? maxEnvHumid,
      int? minEnvHumid,
      int? maxSoilMoist,
      int? minSoilMoist,
      int? maxSoilEc,
      int? minSoilEc,
      String? sunlight,
      String? watering,
      String? fertilization,
      String? pruning,
      String? soil});
}

/// @nodoc
class __$$OpbContributionEntityImplCopyWithImpl<$Res>
    extends _$OpbContributionEntityCopyWithImpl<$Res,
        _$OpbContributionEntityImpl>
    implements _$$OpbContributionEntityImplCopyWith<$Res> {
  __$$OpbContributionEntityImplCopyWithImpl(_$OpbContributionEntityImpl _value,
      $Res Function(_$OpbContributionEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayPid = null,
    Object? alias = freezed,
    Object? category = freezed,
    Object? origin = freezed,
    Object? maxLightMmol = freezed,
    Object? minLightMmol = freezed,
    Object? maxLightLux = freezed,
    Object? minLightLux = freezed,
    Object? maxTemp = freezed,
    Object? minTemp = freezed,
    Object? maxEnvHumid = freezed,
    Object? minEnvHumid = freezed,
    Object? maxSoilMoist = freezed,
    Object? minSoilMoist = freezed,
    Object? maxSoilEc = freezed,
    Object? minSoilEc = freezed,
    Object? sunlight = freezed,
    Object? watering = freezed,
    Object? fertilization = freezed,
    Object? pruning = freezed,
    Object? soil = freezed,
  }) {
    return _then(_$OpbContributionEntityImpl(
      displayPid: null == displayPid
          ? _value.displayPid
          : displayPid // ignore: cast_nullable_to_non_nullable
              as String,
      alias: freezed == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      origin: freezed == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String?,
      maxLightMmol: freezed == maxLightMmol
          ? _value.maxLightMmol
          : maxLightMmol // ignore: cast_nullable_to_non_nullable
              as int?,
      minLightMmol: freezed == minLightMmol
          ? _value.minLightMmol
          : minLightMmol // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLightLux: freezed == maxLightLux
          ? _value.maxLightLux
          : maxLightLux // ignore: cast_nullable_to_non_nullable
              as int?,
      minLightLux: freezed == minLightLux
          ? _value.minLightLux
          : minLightLux // ignore: cast_nullable_to_non_nullable
              as int?,
      maxTemp: freezed == maxTemp
          ? _value.maxTemp
          : maxTemp // ignore: cast_nullable_to_non_nullable
              as int?,
      minTemp: freezed == minTemp
          ? _value.minTemp
          : minTemp // ignore: cast_nullable_to_non_nullable
              as int?,
      maxEnvHumid: freezed == maxEnvHumid
          ? _value.maxEnvHumid
          : maxEnvHumid // ignore: cast_nullable_to_non_nullable
              as int?,
      minEnvHumid: freezed == minEnvHumid
          ? _value.minEnvHumid
          : minEnvHumid // ignore: cast_nullable_to_non_nullable
              as int?,
      maxSoilMoist: freezed == maxSoilMoist
          ? _value.maxSoilMoist
          : maxSoilMoist // ignore: cast_nullable_to_non_nullable
              as int?,
      minSoilMoist: freezed == minSoilMoist
          ? _value.minSoilMoist
          : minSoilMoist // ignore: cast_nullable_to_non_nullable
              as int?,
      maxSoilEc: freezed == maxSoilEc
          ? _value.maxSoilEc
          : maxSoilEc // ignore: cast_nullable_to_non_nullable
              as int?,
      minSoilEc: freezed == minSoilEc
          ? _value.minSoilEc
          : minSoilEc // ignore: cast_nullable_to_non_nullable
              as int?,
      sunlight: freezed == sunlight
          ? _value.sunlight
          : sunlight // ignore: cast_nullable_to_non_nullable
              as String?,
      watering: freezed == watering
          ? _value.watering
          : watering // ignore: cast_nullable_to_non_nullable
              as String?,
      fertilization: freezed == fertilization
          ? _value.fertilization
          : fertilization // ignore: cast_nullable_to_non_nullable
              as String?,
      pruning: freezed == pruning
          ? _value.pruning
          : pruning // ignore: cast_nullable_to_non_nullable
              as String?,
      soil: freezed == soil
          ? _value.soil
          : soil // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$OpbContributionEntityImpl implements _OpbContributionEntity {
  const _$OpbContributionEntityImpl(
      {required this.displayPid,
      this.alias,
      this.category,
      this.origin,
      this.maxLightMmol,
      this.minLightMmol,
      this.maxLightLux,
      this.minLightLux,
      this.maxTemp,
      this.minTemp,
      this.maxEnvHumid,
      this.minEnvHumid,
      this.maxSoilMoist,
      this.minSoilMoist,
      this.maxSoilEc,
      this.minSoilEc,
      this.sunlight,
      this.watering,
      this.fertilization,
      this.pruning,
      this.soil});

  /// OBBLIGATORIO per create. Il pid interno è derivato abbassando a minuscolo.
  /// Deve essere un binomio scientifico (es. "Monstera deliciosa").
  /// MaxLength: 100.
  @override
  final String displayPid;

  /// Nome comune / alias (es. "Swiss Cheese Plant"). MaxLength: 100.
  @override
  final String? alias;

  /// Categoria tassonomica (es. "Aroid"). MaxLength: 100.
  @override
  final String? category;

  /// Origine geografica (es. "Central America"). MaxLength: 100.
  @override
  final String? origin;
// ── Luce ────────────────────────────────────────────────────────
  /// Luce massima in mmol/m²/giorno.
  @override
  final int? maxLightMmol;

  /// Luce minima in mmol/m²/giorno.
  @override
  final int? minLightMmol;

  /// Luce massima in lux.
  @override
  final int? maxLightLux;

  /// Luce minima in lux.
  @override
  final int? minLightLux;
// ── Temperatura ─────────────────────────────────────────────────
  /// Temperatura massima (°C).
  @override
  final int? maxTemp;

  /// Temperatura minima (°C).
  @override
  final int? minTemp;
// ── Umidità ambientale ───────────────────────────────────────────
  /// Umidità ambientale massima (%).
  @override
  final int? maxEnvHumid;

  /// Umidità ambientale minima (%).
  @override
  final int? minEnvHumid;
// ── Umidità del substrato ────────────────────────────────────────
  /// Umidità substrato massima (%).
  @override
  final int? maxSoilMoist;

  /// Umidità substrato minima (%).
  @override
  final int? minSoilMoist;
// ── Conducibilità elettrica ──────────────────────────────────────
  /// EC massima (µS/cm).
  @override
  final int? maxSoilEc;

  /// EC minima (µS/cm).
  @override
  final int? minSoilEc;
// ── Istruzioni di cura testuali ──────────────────────────────────
  /// Descrizione esposizione solare. MaxLength: 200.
  @override
  final String? sunlight;

  /// Istruzioni di irrigazione. MaxLength: 200.
  @override
  final String? watering;

  /// Istruzioni di concimazione. MaxLength: 250.
  @override
  final String? fertilization;

  /// Istruzioni di potatura. MaxLength: 200.
  @override
  final String? pruning;

  /// Tipo di substrato consigliato. MaxLength: 150.
  @override
  final String? soil;

  @override
  String toString() {
    return 'OpbContributionEntity(displayPid: $displayPid, alias: $alias, category: $category, origin: $origin, maxLightMmol: $maxLightMmol, minLightMmol: $minLightMmol, maxLightLux: $maxLightLux, minLightLux: $minLightLux, maxTemp: $maxTemp, minTemp: $minTemp, maxEnvHumid: $maxEnvHumid, minEnvHumid: $minEnvHumid, maxSoilMoist: $maxSoilMoist, minSoilMoist: $minSoilMoist, maxSoilEc: $maxSoilEc, minSoilEc: $minSoilEc, sunlight: $sunlight, watering: $watering, fertilization: $fertilization, pruning: $pruning, soil: $soil)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpbContributionEntityImpl &&
            (identical(other.displayPid, displayPid) ||
                other.displayPid == displayPid) &&
            (identical(other.alias, alias) || other.alias == alias) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.maxLightMmol, maxLightMmol) ||
                other.maxLightMmol == maxLightMmol) &&
            (identical(other.minLightMmol, minLightMmol) ||
                other.minLightMmol == minLightMmol) &&
            (identical(other.maxLightLux, maxLightLux) ||
                other.maxLightLux == maxLightLux) &&
            (identical(other.minLightLux, minLightLux) ||
                other.minLightLux == minLightLux) &&
            (identical(other.maxTemp, maxTemp) || other.maxTemp == maxTemp) &&
            (identical(other.minTemp, minTemp) || other.minTemp == minTemp) &&
            (identical(other.maxEnvHumid, maxEnvHumid) ||
                other.maxEnvHumid == maxEnvHumid) &&
            (identical(other.minEnvHumid, minEnvHumid) ||
                other.minEnvHumid == minEnvHumid) &&
            (identical(other.maxSoilMoist, maxSoilMoist) ||
                other.maxSoilMoist == maxSoilMoist) &&
            (identical(other.minSoilMoist, minSoilMoist) ||
                other.minSoilMoist == minSoilMoist) &&
            (identical(other.maxSoilEc, maxSoilEc) ||
                other.maxSoilEc == maxSoilEc) &&
            (identical(other.minSoilEc, minSoilEc) ||
                other.minSoilEc == minSoilEc) &&
            (identical(other.sunlight, sunlight) ||
                other.sunlight == sunlight) &&
            (identical(other.watering, watering) ||
                other.watering == watering) &&
            (identical(other.fertilization, fertilization) ||
                other.fertilization == fertilization) &&
            (identical(other.pruning, pruning) || other.pruning == pruning) &&
            (identical(other.soil, soil) || other.soil == soil));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        displayPid,
        alias,
        category,
        origin,
        maxLightMmol,
        minLightMmol,
        maxLightLux,
        minLightLux,
        maxTemp,
        minTemp,
        maxEnvHumid,
        minEnvHumid,
        maxSoilMoist,
        minSoilMoist,
        maxSoilEc,
        minSoilEc,
        sunlight,
        watering,
        fertilization,
        pruning,
        soil
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OpbContributionEntityImplCopyWith<_$OpbContributionEntityImpl>
      get copyWith => __$$OpbContributionEntityImplCopyWithImpl<
          _$OpbContributionEntityImpl>(this, _$identity);
}

abstract class _OpbContributionEntity implements OpbContributionEntity {
  const factory _OpbContributionEntity(
      {required final String displayPid,
      final String? alias,
      final String? category,
      final String? origin,
      final int? maxLightMmol,
      final int? minLightMmol,
      final int? maxLightLux,
      final int? minLightLux,
      final int? maxTemp,
      final int? minTemp,
      final int? maxEnvHumid,
      final int? minEnvHumid,
      final int? maxSoilMoist,
      final int? minSoilMoist,
      final int? maxSoilEc,
      final int? minSoilEc,
      final String? sunlight,
      final String? watering,
      final String? fertilization,
      final String? pruning,
      final String? soil}) = _$OpbContributionEntityImpl;

  @override

  /// OBBLIGATORIO per create. Il pid interno è derivato abbassando a minuscolo.
  /// Deve essere un binomio scientifico (es. "Monstera deliciosa").
  /// MaxLength: 100.
  String get displayPid;
  @override

  /// Nome comune / alias (es. "Swiss Cheese Plant"). MaxLength: 100.
  String? get alias;
  @override

  /// Categoria tassonomica (es. "Aroid"). MaxLength: 100.
  String? get category;
  @override

  /// Origine geografica (es. "Central America"). MaxLength: 100.
  String? get origin;
  @override // ── Luce ────────────────────────────────────────────────────────
  /// Luce massima in mmol/m²/giorno.
  int? get maxLightMmol;
  @override

  /// Luce minima in mmol/m²/giorno.
  int? get minLightMmol;
  @override

  /// Luce massima in lux.
  int? get maxLightLux;
  @override

  /// Luce minima in lux.
  int? get minLightLux;
  @override // ── Temperatura ─────────────────────────────────────────────────
  /// Temperatura massima (°C).
  int? get maxTemp;
  @override

  /// Temperatura minima (°C).
  int? get minTemp;
  @override // ── Umidità ambientale ───────────────────────────────────────────
  /// Umidità ambientale massima (%).
  int? get maxEnvHumid;
  @override

  /// Umidità ambientale minima (%).
  int? get minEnvHumid;
  @override // ── Umidità del substrato ────────────────────────────────────────
  /// Umidità substrato massima (%).
  int? get maxSoilMoist;
  @override

  /// Umidità substrato minima (%).
  int? get minSoilMoist;
  @override // ── Conducibilità elettrica ──────────────────────────────────────
  /// EC massima (µS/cm).
  int? get maxSoilEc;
  @override

  /// EC minima (µS/cm).
  int? get minSoilEc;
  @override // ── Istruzioni di cura testuali ──────────────────────────────────
  /// Descrizione esposizione solare. MaxLength: 200.
  String? get sunlight;
  @override

  /// Istruzioni di irrigazione. MaxLength: 200.
  String? get watering;
  @override

  /// Istruzioni di concimazione. MaxLength: 250.
  String? get fertilization;
  @override

  /// Istruzioni di potatura. MaxLength: 200.
  String? get pruning;
  @override

  /// Tipo di substrato consigliato. MaxLength: 150.
  String? get soil;
  @override
  @JsonKey(ignore: true)
  _$$OpbContributionEntityImplCopyWith<_$OpbContributionEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OpbContributionResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pid) success,
    required TResult Function() alreadyExists,
    required TResult Function() rateLimited,
    required TResult Function(String field, String message) validationError,
    required TResult Function() quotaExceeded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pid)? success,
    TResult? Function()? alreadyExists,
    TResult? Function()? rateLimited,
    TResult? Function(String field, String message)? validationError,
    TResult? Function()? quotaExceeded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pid)? success,
    TResult Function()? alreadyExists,
    TResult Function()? rateLimited,
    TResult Function(String field, String message)? validationError,
    TResult Function()? quotaExceeded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OpbContributionSuccess value) success,
    required TResult Function(OpbContributionAlreadyExists value) alreadyExists,
    required TResult Function(OpbContributionRateLimited value) rateLimited,
    required TResult Function(OpbContributionValidationError value)
        validationError,
    required TResult Function(OpbContributionQuotaExceeded value) quotaExceeded,
    required TResult Function(OpbContributionError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OpbContributionSuccess value)? success,
    TResult? Function(OpbContributionAlreadyExists value)? alreadyExists,
    TResult? Function(OpbContributionRateLimited value)? rateLimited,
    TResult? Function(OpbContributionValidationError value)? validationError,
    TResult? Function(OpbContributionQuotaExceeded value)? quotaExceeded,
    TResult? Function(OpbContributionError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OpbContributionSuccess value)? success,
    TResult Function(OpbContributionAlreadyExists value)? alreadyExists,
    TResult Function(OpbContributionRateLimited value)? rateLimited,
    TResult Function(OpbContributionValidationError value)? validationError,
    TResult Function(OpbContributionQuotaExceeded value)? quotaExceeded,
    TResult Function(OpbContributionError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpbContributionResultCopyWith<$Res> {
  factory $OpbContributionResultCopyWith(OpbContributionResult value,
          $Res Function(OpbContributionResult) then) =
      _$OpbContributionResultCopyWithImpl<$Res, OpbContributionResult>;
}

/// @nodoc
class _$OpbContributionResultCopyWithImpl<$Res,
        $Val extends OpbContributionResult>
    implements $OpbContributionResultCopyWith<$Res> {
  _$OpbContributionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OpbContributionSuccessImplCopyWith<$Res> {
  factory _$$OpbContributionSuccessImplCopyWith(
          _$OpbContributionSuccessImpl value,
          $Res Function(_$OpbContributionSuccessImpl) then) =
      __$$OpbContributionSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String pid});
}

/// @nodoc
class __$$OpbContributionSuccessImplCopyWithImpl<$Res>
    extends _$OpbContributionResultCopyWithImpl<$Res,
        _$OpbContributionSuccessImpl>
    implements _$$OpbContributionSuccessImplCopyWith<$Res> {
  __$$OpbContributionSuccessImplCopyWithImpl(
      _$OpbContributionSuccessImpl _value,
      $Res Function(_$OpbContributionSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pid = null,
  }) {
    return _then(_$OpbContributionSuccessImpl(
      pid: null == pid
          ? _value.pid
          : pid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OpbContributionSuccessImpl implements OpbContributionSuccess {
  const _$OpbContributionSuccessImpl({required this.pid});

  @override
  final String pid;

  @override
  String toString() {
    return 'OpbContributionResult.success(pid: $pid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpbContributionSuccessImpl &&
            (identical(other.pid, pid) || other.pid == pid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OpbContributionSuccessImplCopyWith<_$OpbContributionSuccessImpl>
      get copyWith => __$$OpbContributionSuccessImplCopyWithImpl<
          _$OpbContributionSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pid) success,
    required TResult Function() alreadyExists,
    required TResult Function() rateLimited,
    required TResult Function(String field, String message) validationError,
    required TResult Function() quotaExceeded,
    required TResult Function(String message) error,
  }) {
    return success(pid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pid)? success,
    TResult? Function()? alreadyExists,
    TResult? Function()? rateLimited,
    TResult? Function(String field, String message)? validationError,
    TResult? Function()? quotaExceeded,
    TResult? Function(String message)? error,
  }) {
    return success?.call(pid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pid)? success,
    TResult Function()? alreadyExists,
    TResult Function()? rateLimited,
    TResult Function(String field, String message)? validationError,
    TResult Function()? quotaExceeded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(pid);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OpbContributionSuccess value) success,
    required TResult Function(OpbContributionAlreadyExists value) alreadyExists,
    required TResult Function(OpbContributionRateLimited value) rateLimited,
    required TResult Function(OpbContributionValidationError value)
        validationError,
    required TResult Function(OpbContributionQuotaExceeded value) quotaExceeded,
    required TResult Function(OpbContributionError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OpbContributionSuccess value)? success,
    TResult? Function(OpbContributionAlreadyExists value)? alreadyExists,
    TResult? Function(OpbContributionRateLimited value)? rateLimited,
    TResult? Function(OpbContributionValidationError value)? validationError,
    TResult? Function(OpbContributionQuotaExceeded value)? quotaExceeded,
    TResult? Function(OpbContributionError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OpbContributionSuccess value)? success,
    TResult Function(OpbContributionAlreadyExists value)? alreadyExists,
    TResult Function(OpbContributionRateLimited value)? rateLimited,
    TResult Function(OpbContributionValidationError value)? validationError,
    TResult Function(OpbContributionQuotaExceeded value)? quotaExceeded,
    TResult Function(OpbContributionError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class OpbContributionSuccess implements OpbContributionResult {
  const factory OpbContributionSuccess({required final String pid}) =
      _$OpbContributionSuccessImpl;

  String get pid;
  @JsonKey(ignore: true)
  _$$OpbContributionSuccessImplCopyWith<_$OpbContributionSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OpbContributionAlreadyExistsImplCopyWith<$Res> {
  factory _$$OpbContributionAlreadyExistsImplCopyWith(
          _$OpbContributionAlreadyExistsImpl value,
          $Res Function(_$OpbContributionAlreadyExistsImpl) then) =
      __$$OpbContributionAlreadyExistsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OpbContributionAlreadyExistsImplCopyWithImpl<$Res>
    extends _$OpbContributionResultCopyWithImpl<$Res,
        _$OpbContributionAlreadyExistsImpl>
    implements _$$OpbContributionAlreadyExistsImplCopyWith<$Res> {
  __$$OpbContributionAlreadyExistsImplCopyWithImpl(
      _$OpbContributionAlreadyExistsImpl _value,
      $Res Function(_$OpbContributionAlreadyExistsImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OpbContributionAlreadyExistsImpl
    implements OpbContributionAlreadyExists {
  const _$OpbContributionAlreadyExistsImpl();

  @override
  String toString() {
    return 'OpbContributionResult.alreadyExists()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpbContributionAlreadyExistsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pid) success,
    required TResult Function() alreadyExists,
    required TResult Function() rateLimited,
    required TResult Function(String field, String message) validationError,
    required TResult Function() quotaExceeded,
    required TResult Function(String message) error,
  }) {
    return alreadyExists();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pid)? success,
    TResult? Function()? alreadyExists,
    TResult? Function()? rateLimited,
    TResult? Function(String field, String message)? validationError,
    TResult? Function()? quotaExceeded,
    TResult? Function(String message)? error,
  }) {
    return alreadyExists?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pid)? success,
    TResult Function()? alreadyExists,
    TResult Function()? rateLimited,
    TResult Function(String field, String message)? validationError,
    TResult Function()? quotaExceeded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (alreadyExists != null) {
      return alreadyExists();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OpbContributionSuccess value) success,
    required TResult Function(OpbContributionAlreadyExists value) alreadyExists,
    required TResult Function(OpbContributionRateLimited value) rateLimited,
    required TResult Function(OpbContributionValidationError value)
        validationError,
    required TResult Function(OpbContributionQuotaExceeded value) quotaExceeded,
    required TResult Function(OpbContributionError value) error,
  }) {
    return alreadyExists(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OpbContributionSuccess value)? success,
    TResult? Function(OpbContributionAlreadyExists value)? alreadyExists,
    TResult? Function(OpbContributionRateLimited value)? rateLimited,
    TResult? Function(OpbContributionValidationError value)? validationError,
    TResult? Function(OpbContributionQuotaExceeded value)? quotaExceeded,
    TResult? Function(OpbContributionError value)? error,
  }) {
    return alreadyExists?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OpbContributionSuccess value)? success,
    TResult Function(OpbContributionAlreadyExists value)? alreadyExists,
    TResult Function(OpbContributionRateLimited value)? rateLimited,
    TResult Function(OpbContributionValidationError value)? validationError,
    TResult Function(OpbContributionQuotaExceeded value)? quotaExceeded,
    TResult Function(OpbContributionError value)? error,
    required TResult orElse(),
  }) {
    if (alreadyExists != null) {
      return alreadyExists(this);
    }
    return orElse();
  }
}

abstract class OpbContributionAlreadyExists implements OpbContributionResult {
  const factory OpbContributionAlreadyExists() =
      _$OpbContributionAlreadyExistsImpl;
}

/// @nodoc
abstract class _$$OpbContributionRateLimitedImplCopyWith<$Res> {
  factory _$$OpbContributionRateLimitedImplCopyWith(
          _$OpbContributionRateLimitedImpl value,
          $Res Function(_$OpbContributionRateLimitedImpl) then) =
      __$$OpbContributionRateLimitedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OpbContributionRateLimitedImplCopyWithImpl<$Res>
    extends _$OpbContributionResultCopyWithImpl<$Res,
        _$OpbContributionRateLimitedImpl>
    implements _$$OpbContributionRateLimitedImplCopyWith<$Res> {
  __$$OpbContributionRateLimitedImplCopyWithImpl(
      _$OpbContributionRateLimitedImpl _value,
      $Res Function(_$OpbContributionRateLimitedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OpbContributionRateLimitedImpl implements OpbContributionRateLimited {
  const _$OpbContributionRateLimitedImpl();

  @override
  String toString() {
    return 'OpbContributionResult.rateLimited()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpbContributionRateLimitedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pid) success,
    required TResult Function() alreadyExists,
    required TResult Function() rateLimited,
    required TResult Function(String field, String message) validationError,
    required TResult Function() quotaExceeded,
    required TResult Function(String message) error,
  }) {
    return rateLimited();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pid)? success,
    TResult? Function()? alreadyExists,
    TResult? Function()? rateLimited,
    TResult? Function(String field, String message)? validationError,
    TResult? Function()? quotaExceeded,
    TResult? Function(String message)? error,
  }) {
    return rateLimited?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pid)? success,
    TResult Function()? alreadyExists,
    TResult Function()? rateLimited,
    TResult Function(String field, String message)? validationError,
    TResult Function()? quotaExceeded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (rateLimited != null) {
      return rateLimited();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OpbContributionSuccess value) success,
    required TResult Function(OpbContributionAlreadyExists value) alreadyExists,
    required TResult Function(OpbContributionRateLimited value) rateLimited,
    required TResult Function(OpbContributionValidationError value)
        validationError,
    required TResult Function(OpbContributionQuotaExceeded value) quotaExceeded,
    required TResult Function(OpbContributionError value) error,
  }) {
    return rateLimited(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OpbContributionSuccess value)? success,
    TResult? Function(OpbContributionAlreadyExists value)? alreadyExists,
    TResult? Function(OpbContributionRateLimited value)? rateLimited,
    TResult? Function(OpbContributionValidationError value)? validationError,
    TResult? Function(OpbContributionQuotaExceeded value)? quotaExceeded,
    TResult? Function(OpbContributionError value)? error,
  }) {
    return rateLimited?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OpbContributionSuccess value)? success,
    TResult Function(OpbContributionAlreadyExists value)? alreadyExists,
    TResult Function(OpbContributionRateLimited value)? rateLimited,
    TResult Function(OpbContributionValidationError value)? validationError,
    TResult Function(OpbContributionQuotaExceeded value)? quotaExceeded,
    TResult Function(OpbContributionError value)? error,
    required TResult orElse(),
  }) {
    if (rateLimited != null) {
      return rateLimited(this);
    }
    return orElse();
  }
}

abstract class OpbContributionRateLimited implements OpbContributionResult {
  const factory OpbContributionRateLimited() = _$OpbContributionRateLimitedImpl;
}

/// @nodoc
abstract class _$$OpbContributionValidationErrorImplCopyWith<$Res> {
  factory _$$OpbContributionValidationErrorImplCopyWith(
          _$OpbContributionValidationErrorImpl value,
          $Res Function(_$OpbContributionValidationErrorImpl) then) =
      __$$OpbContributionValidationErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String field, String message});
}

/// @nodoc
class __$$OpbContributionValidationErrorImplCopyWithImpl<$Res>
    extends _$OpbContributionResultCopyWithImpl<$Res,
        _$OpbContributionValidationErrorImpl>
    implements _$$OpbContributionValidationErrorImplCopyWith<$Res> {
  __$$OpbContributionValidationErrorImplCopyWithImpl(
      _$OpbContributionValidationErrorImpl _value,
      $Res Function(_$OpbContributionValidationErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? message = null,
  }) {
    return _then(_$OpbContributionValidationErrorImpl(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OpbContributionValidationErrorImpl
    implements OpbContributionValidationError {
  const _$OpbContributionValidationErrorImpl(
      {required this.field, required this.message});

  @override
  final String field;
  @override
  final String message;

  @override
  String toString() {
    return 'OpbContributionResult.validationError(field: $field, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpbContributionValidationErrorImpl &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OpbContributionValidationErrorImplCopyWith<
          _$OpbContributionValidationErrorImpl>
      get copyWith => __$$OpbContributionValidationErrorImplCopyWithImpl<
          _$OpbContributionValidationErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pid) success,
    required TResult Function() alreadyExists,
    required TResult Function() rateLimited,
    required TResult Function(String field, String message) validationError,
    required TResult Function() quotaExceeded,
    required TResult Function(String message) error,
  }) {
    return validationError(field, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pid)? success,
    TResult? Function()? alreadyExists,
    TResult? Function()? rateLimited,
    TResult? Function(String field, String message)? validationError,
    TResult? Function()? quotaExceeded,
    TResult? Function(String message)? error,
  }) {
    return validationError?.call(field, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pid)? success,
    TResult Function()? alreadyExists,
    TResult Function()? rateLimited,
    TResult Function(String field, String message)? validationError,
    TResult Function()? quotaExceeded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (validationError != null) {
      return validationError(field, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OpbContributionSuccess value) success,
    required TResult Function(OpbContributionAlreadyExists value) alreadyExists,
    required TResult Function(OpbContributionRateLimited value) rateLimited,
    required TResult Function(OpbContributionValidationError value)
        validationError,
    required TResult Function(OpbContributionQuotaExceeded value) quotaExceeded,
    required TResult Function(OpbContributionError value) error,
  }) {
    return validationError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OpbContributionSuccess value)? success,
    TResult? Function(OpbContributionAlreadyExists value)? alreadyExists,
    TResult? Function(OpbContributionRateLimited value)? rateLimited,
    TResult? Function(OpbContributionValidationError value)? validationError,
    TResult? Function(OpbContributionQuotaExceeded value)? quotaExceeded,
    TResult? Function(OpbContributionError value)? error,
  }) {
    return validationError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OpbContributionSuccess value)? success,
    TResult Function(OpbContributionAlreadyExists value)? alreadyExists,
    TResult Function(OpbContributionRateLimited value)? rateLimited,
    TResult Function(OpbContributionValidationError value)? validationError,
    TResult Function(OpbContributionQuotaExceeded value)? quotaExceeded,
    TResult Function(OpbContributionError value)? error,
    required TResult orElse(),
  }) {
    if (validationError != null) {
      return validationError(this);
    }
    return orElse();
  }
}

abstract class OpbContributionValidationError implements OpbContributionResult {
  const factory OpbContributionValidationError(
      {required final String field,
      required final String message}) = _$OpbContributionValidationErrorImpl;

  String get field;
  String get message;
  @JsonKey(ignore: true)
  _$$OpbContributionValidationErrorImplCopyWith<
          _$OpbContributionValidationErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OpbContributionQuotaExceededImplCopyWith<$Res> {
  factory _$$OpbContributionQuotaExceededImplCopyWith(
          _$OpbContributionQuotaExceededImpl value,
          $Res Function(_$OpbContributionQuotaExceededImpl) then) =
      __$$OpbContributionQuotaExceededImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OpbContributionQuotaExceededImplCopyWithImpl<$Res>
    extends _$OpbContributionResultCopyWithImpl<$Res,
        _$OpbContributionQuotaExceededImpl>
    implements _$$OpbContributionQuotaExceededImplCopyWith<$Res> {
  __$$OpbContributionQuotaExceededImplCopyWithImpl(
      _$OpbContributionQuotaExceededImpl _value,
      $Res Function(_$OpbContributionQuotaExceededImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OpbContributionQuotaExceededImpl
    implements OpbContributionQuotaExceeded {
  const _$OpbContributionQuotaExceededImpl();

  @override
  String toString() {
    return 'OpbContributionResult.quotaExceeded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpbContributionQuotaExceededImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pid) success,
    required TResult Function() alreadyExists,
    required TResult Function() rateLimited,
    required TResult Function(String field, String message) validationError,
    required TResult Function() quotaExceeded,
    required TResult Function(String message) error,
  }) {
    return quotaExceeded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pid)? success,
    TResult? Function()? alreadyExists,
    TResult? Function()? rateLimited,
    TResult? Function(String field, String message)? validationError,
    TResult? Function()? quotaExceeded,
    TResult? Function(String message)? error,
  }) {
    return quotaExceeded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pid)? success,
    TResult Function()? alreadyExists,
    TResult Function()? rateLimited,
    TResult Function(String field, String message)? validationError,
    TResult Function()? quotaExceeded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (quotaExceeded != null) {
      return quotaExceeded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OpbContributionSuccess value) success,
    required TResult Function(OpbContributionAlreadyExists value) alreadyExists,
    required TResult Function(OpbContributionRateLimited value) rateLimited,
    required TResult Function(OpbContributionValidationError value)
        validationError,
    required TResult Function(OpbContributionQuotaExceeded value) quotaExceeded,
    required TResult Function(OpbContributionError value) error,
  }) {
    return quotaExceeded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OpbContributionSuccess value)? success,
    TResult? Function(OpbContributionAlreadyExists value)? alreadyExists,
    TResult? Function(OpbContributionRateLimited value)? rateLimited,
    TResult? Function(OpbContributionValidationError value)? validationError,
    TResult? Function(OpbContributionQuotaExceeded value)? quotaExceeded,
    TResult? Function(OpbContributionError value)? error,
  }) {
    return quotaExceeded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OpbContributionSuccess value)? success,
    TResult Function(OpbContributionAlreadyExists value)? alreadyExists,
    TResult Function(OpbContributionRateLimited value)? rateLimited,
    TResult Function(OpbContributionValidationError value)? validationError,
    TResult Function(OpbContributionQuotaExceeded value)? quotaExceeded,
    TResult Function(OpbContributionError value)? error,
    required TResult orElse(),
  }) {
    if (quotaExceeded != null) {
      return quotaExceeded(this);
    }
    return orElse();
  }
}

abstract class OpbContributionQuotaExceeded implements OpbContributionResult {
  const factory OpbContributionQuotaExceeded() =
      _$OpbContributionQuotaExceededImpl;
}

/// @nodoc
abstract class _$$OpbContributionErrorImplCopyWith<$Res> {
  factory _$$OpbContributionErrorImplCopyWith(_$OpbContributionErrorImpl value,
          $Res Function(_$OpbContributionErrorImpl) then) =
      __$$OpbContributionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$OpbContributionErrorImplCopyWithImpl<$Res>
    extends _$OpbContributionResultCopyWithImpl<$Res,
        _$OpbContributionErrorImpl>
    implements _$$OpbContributionErrorImplCopyWith<$Res> {
  __$$OpbContributionErrorImplCopyWithImpl(_$OpbContributionErrorImpl _value,
      $Res Function(_$OpbContributionErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$OpbContributionErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OpbContributionErrorImpl implements OpbContributionError {
  const _$OpbContributionErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'OpbContributionResult.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpbContributionErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OpbContributionErrorImplCopyWith<_$OpbContributionErrorImpl>
      get copyWith =>
          __$$OpbContributionErrorImplCopyWithImpl<_$OpbContributionErrorImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pid) success,
    required TResult Function() alreadyExists,
    required TResult Function() rateLimited,
    required TResult Function(String field, String message) validationError,
    required TResult Function() quotaExceeded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pid)? success,
    TResult? Function()? alreadyExists,
    TResult? Function()? rateLimited,
    TResult? Function(String field, String message)? validationError,
    TResult? Function()? quotaExceeded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pid)? success,
    TResult Function()? alreadyExists,
    TResult Function()? rateLimited,
    TResult Function(String field, String message)? validationError,
    TResult Function()? quotaExceeded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OpbContributionSuccess value) success,
    required TResult Function(OpbContributionAlreadyExists value) alreadyExists,
    required TResult Function(OpbContributionRateLimited value) rateLimited,
    required TResult Function(OpbContributionValidationError value)
        validationError,
    required TResult Function(OpbContributionQuotaExceeded value) quotaExceeded,
    required TResult Function(OpbContributionError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OpbContributionSuccess value)? success,
    TResult? Function(OpbContributionAlreadyExists value)? alreadyExists,
    TResult? Function(OpbContributionRateLimited value)? rateLimited,
    TResult? Function(OpbContributionValidationError value)? validationError,
    TResult? Function(OpbContributionQuotaExceeded value)? quotaExceeded,
    TResult? Function(OpbContributionError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OpbContributionSuccess value)? success,
    TResult Function(OpbContributionAlreadyExists value)? alreadyExists,
    TResult Function(OpbContributionRateLimited value)? rateLimited,
    TResult Function(OpbContributionValidationError value)? validationError,
    TResult Function(OpbContributionQuotaExceeded value)? quotaExceeded,
    TResult Function(OpbContributionError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class OpbContributionError implements OpbContributionResult {
  const factory OpbContributionError({required final String message}) =
      _$OpbContributionErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$OpbContributionErrorImplCopyWith<_$OpbContributionErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
