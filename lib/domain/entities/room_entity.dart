import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_entity.freezed.dart';
part 'room_entity.g.dart';

@freezed
class RoomEntity with _$RoomEntity {
  const factory RoomEntity({
    required String id,
    required String userId,
    required String name,

    /// N | NE | E | SE | S | SW | W | NW | UNKNOWN
    required String exposure,
    required DateTime createdAt,
    @Default(false) bool exposureConfirmedByUser,
    int? floor,
    String? notes,
  }) = _RoomEntity;

  factory RoomEntity.fromJson(Map<String, dynamic> json) =>
      _$RoomEntityFromJson(json);
}
