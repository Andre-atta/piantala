// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlantEntityImpl _$$PlantEntityImplFromJson(Map<String, dynamic> json) =>
    _$PlantEntityImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      roomId: json['roomId'] as String,
      customName: json['customName'] as String,
      shelfPosition: (json['shelfPosition'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      speciesApiId: json['speciesApiId'] as String?,
      speciesCommonName: json['speciesCommonName'] as String?,
      speciesScientificName: json['speciesScientificName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      wateringConfig: json['wateringConfig'] == null
          ? null
          : WateringConfigEntity.fromJson(
              json['wateringConfig'] as Map<String, dynamic>),
      careConfig: json['careConfig'] == null
          ? null
          : CareConfigEntity.fromJson(
              json['careConfig'] as Map<String, dynamic>),
      fertilizingConfig: json['fertilizingConfig'] == null
          ? null
          : FertilizingConfigEntity.fromJson(
              json['fertilizingConfig'] as Map<String, dynamic>),
      acquisitionDate: json['acquisitionDate'] == null
          ? null
          : DateTime.parse(json['acquisitionDate'] as String),
      notes: json['notes'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      isArchived: json['isArchived'] as bool? ?? false,
      cultivationMethod: json['cultivationMethod'] as String? ?? 'soil',
    );

Map<String, dynamic> _$$PlantEntityImplToJson(_$PlantEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'roomId': instance.roomId,
      'customName': instance.customName,
      'shelfPosition': instance.shelfPosition,
      'createdAt': instance.createdAt.toIso8601String(),
      'speciesApiId': instance.speciesApiId,
      'speciesCommonName': instance.speciesCommonName,
      'speciesScientificName': instance.speciesScientificName,
      'photoUrl': instance.photoUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'wateringConfig': instance.wateringConfig?.toJson(),
      'careConfig': instance.careConfig?.toJson(),
      'fertilizingConfig': instance.fertilizingConfig?.toJson(),
      'acquisitionDate': instance.acquisitionDate?.toIso8601String(),
      'notes': instance.notes,
      'tags': instance.tags,
      'isArchived': instance.isArchived,
      'cultivationMethod': instance.cultivationMethod,
    };

_$WateringConfigEntityImpl _$$WateringConfigEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$WateringConfigEntityImpl(
      frequencyDays: (json['frequencyDays'] as num).toInt(),
      lastWateredAt: json['lastWateredAt'] == null
          ? null
          : DateTime.parse(json['lastWateredAt'] as String),
    );

Map<String, dynamic> _$$WateringConfigEntityImplToJson(
        _$WateringConfigEntityImpl instance) =>
    <String, dynamic>{
      'frequencyDays': instance.frequencyDays,
      'lastWateredAt': instance.lastWateredAt?.toIso8601String(),
    };

_$CareConfigEntityImpl _$$CareConfigEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$CareConfigEntityImpl(
      fertilizingFrequencyDays:
          (json['fertilizingFrequencyDays'] as num?)?.toInt(),
      lastFertilizedAt: json['lastFertilizedAt'] == null
          ? null
          : DateTime.parse(json['lastFertilizedAt'] as String),
      lastRepottedAt: json['lastRepottedAt'] == null
          ? null
          : DateTime.parse(json['lastRepottedAt'] as String),
    );

Map<String, dynamic> _$$CareConfigEntityImplToJson(
        _$CareConfigEntityImpl instance) =>
    <String, dynamic>{
      'fertilizingFrequencyDays': instance.fertilizingFrequencyDays,
      'lastFertilizedAt': instance.lastFertilizedAt?.toIso8601String(),
      'lastRepottedAt': instance.lastRepottedAt?.toIso8601String(),
    };

_$FertilizingConfigEntityImpl _$$FertilizingConfigEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$FertilizingConfigEntityImpl(
      frequencyDays: (json['frequencyDays'] as num).toInt(),
      lastFertilizedAt: json['lastFertilizedAt'] == null
          ? null
          : DateTime.parse(json['lastFertilizedAt'] as String),
    );

Map<String, dynamic> _$$FertilizingConfigEntityImplToJson(
        _$FertilizingConfigEntityImpl instance) =>
    <String, dynamic>{
      'frequencyDays': instance.frequencyDays,
      'lastFertilizedAt': instance.lastFertilizedAt?.toIso8601String(),
    };
