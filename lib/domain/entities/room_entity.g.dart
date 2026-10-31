// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomEntityImpl _$$RoomEntityImplFromJson(Map<String, dynamic> json) =>
    _$RoomEntityImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      exposure: json['exposure'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      exposureConfirmedByUser:
          json['exposureConfirmedByUser'] as bool? ?? false,
      floor: (json['floor'] as num?)?.toInt(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$RoomEntityImplToJson(_$RoomEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'exposure': instance.exposure,
      'createdAt': instance.createdAt.toIso8601String(),
      'exposureConfirmedByUser': instance.exposureConfirmedByUser,
      'floor': instance.floor,
      'notes': instance.notes,
    };
