import 'package:freezed_annotation/freezed_annotation.dart';

part 'plant_entity.freezed.dart';
part 'plant_entity.g.dart';

@freezed
class PlantEntity with _$PlantEntity {
  const factory PlantEntity({
    required String id,
    required String userId,
    required String roomId,
    required String customName,
    required int shelfPosition,
    required DateTime createdAt,
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
    @Default([]) List<String> tags,
    @Default(false) bool isArchived,
    @Default('soil') String cultivationMethod,
  }) = _PlantEntity;

  const PlantEntity._();

  factory PlantEntity.fromJson(Map<String, dynamic> json) =>
      _$PlantEntityFromJson(json);

  String get canonicalSpeciesSlug {
    if (speciesScientificName == null ||
        speciesScientificName!.trim().isEmpty) {
      return '';
    }
    return speciesScientificName!
        .replaceAll(RegExp(r"'[^']*'"), '')
        .replaceAll(RegExp(r'"[^"]*"'), '')
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'\s+'), '_');
  }
}

@freezed
class WateringConfigEntity with _$WateringConfigEntity {
  const factory WateringConfigEntity({
    required int frequencyDays,
    DateTime? lastWateredAt,
  }) = _WateringConfigEntity;

  factory WateringConfigEntity.fromJson(Map<String, dynamic> json) =>
      _$WateringConfigEntityFromJson(json);
}

@freezed
class CareConfigEntity with _$CareConfigEntity {
  const factory CareConfigEntity({
    int? fertilizingFrequencyDays,
    DateTime? lastFertilizedAt,
    DateTime? lastRepottedAt,
  }) = _CareConfigEntity;

  factory CareConfigEntity.fromJson(Map<String, dynamic> json) =>
      _$CareConfigEntityFromJson(json);
}

@freezed
class FertilizingConfigEntity with _$FertilizingConfigEntity {
  const factory FertilizingConfigEntity({
    required int frequencyDays,
    DateTime? lastFertilizedAt,
  }) = _FertilizingConfigEntity;

  factory FertilizingConfigEntity.fromJson(Map<String, dynamic> json) =>
      _$FertilizingConfigEntityFromJson(json);
}
